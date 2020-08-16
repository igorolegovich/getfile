<?php
    function searchFacebook($link) {
        $obj = new resultSearch;
        $obj->urlPost = $link;
        
        $ch=curl_init(); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 25);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
        curl_setopt($ch, CURLOPT_HTTPPROXYTUNNEL, 1); 
        curl_setopt($ch, CURLOPT_FAILONERROR, true);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13'); 
        curl_setopt($ch, CURLOPT_URL, $link);
        $html = curl_exec($ch); 
        curl_close($ch);
        
        //echo '<pre>'.htmlspecialchars($html).'</pre>';
        
        $lpage = stristr($html, 'onloadRegister_DEPRECATED', true);
        
        if (stristr($html, 'fwb fcg')) {
            $llpage = stristr($html, 'fwb fcg');
            $llpage = stristr($llpage, '<span>');
            $llpage = stristr($llpage, '</span>', true);
            $obj->nicknameUser = stristr($llpage, '>');
            $obj->nicknameUser = str_ireplace(">", "", $obj->nicknameUser);
        } else {
            $llpage = stristr($html, 'onloadRegister_DEPRECATED', true);
            $llpage = stristr($llpage, 'og:title');
            $nicknameUser = stristr($llpage, '>', true);
            $obj->nicknameUser = substr($nicknameUser, stripos($nicknameUser, '=') + 2, stripos($nicknameUser, '/') - (stripos($nicknameUser, '=') + 4));
        }
        
        if (!stristr($html, '_4ooo')) {
            $llpage = stristr($lpage, 'og:image');
            $urlAvatar = stristr($llpage, '<', true);
            $obj->urlAvatar = htmlspecialchars(substr($urlAvatar, stripos($urlAvatar, '=') + 2, stripos($urlAvatar, '>') - (stripos($urlAvatar, '=') + 5)));
            $obj->urlAvatar = str_ireplace("amp;", "", $obj->urlAvatar);
        } else {
            $llpage = stristr($html, '_4ooo');
            $urlAvatar = stristr($llpage, 'aria', true);
            $obj->urlAvatar = htmlspecialchars(substr($urlAvatar, stripos($urlAvatar, '=') + 2, stripos($urlAvatar, 'alt') - (stripos($urlAvatar, '=') + 4)));
            $obj->urlAvatar = str_ireplace("amp;", "", $obj->urlAvatar);
        }
        
        if (stristr($html, 'video_url')) {
            $obj->typePost = 'GraphVideo';
            $obj->typeCell = 'Видео';
            
            $llpage = stristr($html, '_3chq');
            $urlImage = stristr($llpage, 'div', true);
            $obj->urlImage = htmlspecialchars(substr($urlImage, stripos($urlImage, '=') + 2, stripos($urlImage, ' ') - (stripos($urlImage, '=') + 1)));
            $obj->urlImage = str_ireplace("amp;", "", $obj->urlImage);
            
            $VideoPage = stristr($html, 'hd_src');
            
            $urlVideo = stristr($VideoPage, 'sd_src', true);
            
            if (!stristr($urlVideo, 'null')) {
                $obj->urlForVideo720p = htmlspecialchars(substr($urlVideo, stripos($urlVideo, ':') + 2, stripos($urlVideo, ',') - (stripos($urlVideo, ':') + 3)));
                $obj->urlForVideo720p = str_ireplace("\/", "/", $obj->urlForVideo720p);
                $obj->urlForVideo720p = str_ireplace("amp;", "", $obj->urlForVideo720p);
            }
            
            $urlVideo = stristr($VideoPage, 'sd_src');
            $urlVideo = stristr($urlVideo, 'hd_tag', true);
            $obj->urlForVideo360p = htmlspecialchars(substr($urlVideo, stripos($urlVideo, ':') + 2, stripos($urlVideo, ',') - (stripos($urlVideo, ':') + 3)));
            $obj->urlForVideo360p = str_ireplace("\/", "/", $obj->urlForVideo360p);
            $obj->urlForVideo360p = str_ireplace("amp;", "", $obj->urlForVideo360p);
        } else {
            $obj->typePost = 'GraphImage';
            $obj->typeCell = 'Изображение';
            
            $llpage = stristr($html, 'data-ploi');
            $urlImage = stristr($llpage, 'class', true);
            $obj->urlImage = htmlspecialchars(substr($urlImage, stripos($urlImage, '=') + 2, stripos($urlImage, ' ') - (stripos($urlImage, '=') + 3)));
            $obj->urlImage = str_ireplace("amp;", "", $obj->urlImage);
        }
        
        $lpage = stristr($html, 'post_message');
        $textPost = stristr($lpage, '</p>', true);
        if (stristr($textPost, '<span')) {
            $textPost = stristr($textPost, 'p>');
            $textPost = stristr($textPost, '<span', true);
        } else {
            $textPost = stristr($textPost, 'p>');
        }
        
        $obj->textPost = str_ireplace(">", "", stristr($textPost, '>')).' ';
        
        $lpage = stristr($html, '__typename');
        $lpage = stristr($lpage, 'display_comments_count', true);
        
        $idUser = stristr($lpage, ',');
        $idUser = stristr($idUser, 'num', true);
        $obj->idUser = substr($idUser, stripos($idUser, ':') + 2, stripos($idUser, '}') - (stripos($idUser, ':') + 3)).' ';
        
        $countComment = stristr($lpage, 'comment_count');
        $countComment = stristr($countComment, '}', true);
        $countComment = stristr($countComment, '{');
        $obj->countComment = str_ireplace(":", "", stristr($countComment, ':')).' ';
        
        $countLikes = stristr($lpage, 'important_reactors');
        $countLikes = stristr($countLikes, 'reaction_count');
        $countLikes = stristr($countLikes, '}', true);
        $countLikes = stristr($countLikes, '{');
        $obj->countLikes = str_ireplace(":", "", stristr($countLikes, ':')).' ';
        
        $countView = stristr($lpage, 'share_count');
        $countView = stristr($countView, '}', true);
        $countView = stristr($countView, '{');
        $obj->countView = str_ireplace(":", "", stristr($countView, ':')).' ';
        
        if (empty($obj->urlImage) and empty($obj->urlImageEdges)) {
            return error(403);
        } else {
            return $obj;
        }
    }
?>