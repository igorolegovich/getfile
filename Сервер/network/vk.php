<?php
    function searchVideoVK($lobj, $urlVideo) {
        $videoPage = file_get_contents('https://vk.com/'.$urlVideo);
        $videoPage = stristr($videoPage, 'layout__basis');
        $videoPage = stristr($videoPage, 'poster');
        $videoPage = stristr($videoPage, 'vv_not_support', true);
        
        //echo '<pre>'.htmlspecialchars($videoPage).'</pre>';
        
        if ($lobj->typePost == 'GraphSidecar') {
            array_push($lobj->urlImageEdges, htmlspecialchars(substr($videoPage, stripos($videoPage, '=') + 2, stripos($videoPage, ' ') - (stripos($videoPage, '=') + 3))));
        } else {
            $lobj->urlImage = htmlspecialchars(substr($videoPage, stripos($videoPage, '=') + 2, stripos($videoPage, ' ') - (stripos($videoPage, '=') + 3)));
        }
        
        $videoURL = stristr($videoPage, 'application');
        $videoURL = htmlspecialchars(substr($videoURL, stripos($videoURL, '=') + 2, stripos($videoURL, 'type') - (stripos($videoURL, '=') + 4)));
        
        if ($lobj->typePost == 'GraphSidecar') {
            if (stristr($videoPage, 'dirs%5B1080%5D')) {
                array_push($lobj->urlVideoEdges, str_ireplace("240.mp4", "1080.mp4", $videoURL));
            }
            else
                if (stristr($videoPage, 'dirs%5B720%5D')) {
                    array_push($lobj->urlVideoEdges, str_ireplace("240.mp4", "720.mp4", $videoURL));
                }
            else
                if (stristr($videoPage, 'dirs%5B480%5D')) {
                    array_push($lobj->urlVideoEdges, str_ireplace("240.mp4", "480.mp4", $videoURL));
                }
            else
                if (stristr($videoPage, 'dirs%5B360%5D')) {
                    array_push($lobj->urlVideoEdges, str_ireplace("240.mp4", "360.mp4", $videoURL));
                }
            else
                if (stristr($videoPage, 'dirs%5B240%5D')) {
                    array_push($lobj->urlVideoEdges, $videoURL);
                }
            else
                array_push($lobj->urlVideoEdges, 'nil');
                
            return $lobj;
        } else {
            if (stristr($videoPage, 'dirs%5B1080%5D')) {
                $lobj->urlForVideo1080p = str_ireplace("240.mp4", "1080.mp4", $videoURL);
            }
            
            if (stristr($videoPage, 'dirs%5B720%5D')) {
                $lobj->urlForVideo720p = str_ireplace("240.mp4", "720.mp4", $videoURL);
            }
            
            if (stristr($videoPage, 'dirs%5B480%5D')) {
                $lobj->urlForVideo480p = str_ireplace("240.mp4", "480.mp4", $videoURL);
            }
            
            if (stristr($videoPage, 'dirs%5B360%5D')) {
                $lobj->urlForVideo360p = str_ireplace("240.mp4", "360.mp4", $videoURL);
            }
            
            if (stristr($videoPage, 'dirs%5B240%5D')) {
                $lobj->urlForVideo240p = $videoURL;
            }
            
            return $lobj;
        }
    }

    function searchVK($link) {
        $obj = new resultSearch;
        $obj->urlPost = $link;
        
        $page = file_get_contents($link);
        $page = stristr($page, 'wi_head');
        
        if (stristr($page, 'Replies')) {
            $page = stristr($page, 'Replies', true);
        }
        
        $lpage = stristr($page, 'wi_cont', true); 
        $obj->urlAvatar = htmlspecialchars(substr($lpage, stripos($lpage, 'src=') + 5, stripos($lpage, 'class') - (stripos($lpage, 'src=') + 7)));
        
        $lpage = stristr($page, 'wi_cont');
        $lpage = stristr($lpage, 'wi_info', true);
        $obj->idUser = htmlspecialchars(substr($lpage, stripos($lpage, 'href') + 7, stripos($lpage, '?from') - (stripos($lpage, 'href') + 7))).' ';
        $lpage = stristr($lpage, 'post_owner_link');
        $obj->nicknameUser = (string)htmlspecialchars(substr($lpage, stripos($lpage, '">') + 2, stripos($lpage, '</') - (stripos($lpage, '">') + 2)));
        
        $lpage = stristr($page, 'pi_text');
        $lpage = stristr($lpage, '/div', true);
        $obj->textPost = htmlspecialchars(substr($lpage, stripos($lpage, '>') + 1, stripos($lpage, '<') - (stripos($lpage, '>') + 1)));
        
        $lpage = stristr($page, 'wi_buttons_wrap');
        $lpage = stristr($lpage, 'aria-label');
        $obj->countLikes = (string)htmlspecialchars(substr($lpage, stripos($lpage, '"') + 1, stripos($lpage, ' ') - (stripos($lpage, '"') + 1))).' ';
        $lpage = stristr($lpage, 'i_like');
        
        $lpage = stristr($lpage, 'aria-label');
        $obj->countComment = (string)htmlspecialchars(substr($lpage, stripos($lpage, '"') + 1, stripos($lpage, ' ') - (stripos($lpage, '"') + 1))).' ';
        $lpage = stristr($lpage, 'item_views');
        
        $lpage = stristr($lpage, 'aria-label');
        $obj->countView = (string)htmlspecialchars(substr($lpage, stripos($lpage, '"') + 1, stripos($lpage, ' ') - (stripos($lpage, '"') + 1))).' ';
        
        $profilePage = file_get_contents('https://vk.com/'.$obj->idUser);
        $countSubscrite = stristr($profilePage, 'Подписчики');
        $countSubscrite = stristr($countSubscrite, 'pm_item', true);
        $countRepeats = substr_count($countSubscrite, 'num_delim') + 1;
        $part1 = htmlspecialchars(substr($countSubscrite, stripos($countSubscrite, '>') + 1, stripos($countSubscrite, 'span') - (stripos($countSubscrite, '>') + 2)));
        $countSubscrite = stristr($countSubscrite, 'num_delim');
        if ($countRepeats == 3) {
            $part2 = htmlspecialchars(substr($countSubscrite, stripos($countSubscrite, '/span') + 6, stripos($countSubscrite, 'span') - (stripos($countSubscrite, '/span')-2)));
            $countSubscrite = stristr($countSubscrite, 'class');
        } else {
            $part2 = '';
        }
        $part3 = htmlspecialchars(substr($countSubscrite, stripos($countSubscrite, '/span') + 6, stripos($countSubscrite, '/em') - (stripos($countSubscrite, '/span') + 7)));
        
        if ($part1.$part2.$part3 == '') {
            $obj->countSubscrite = '';
        } else {
            $obj->countSubscrite = $part1.$part2.$part3.' ';
        }

        $countRepeats = substr_count($page, 'data-src_big');
        if ($countRepeats == 0) {
            $obj->typePost = 'GraphVideo';
            $obj->typeCell = 'Видео';
            
            $urlVideo = stristr($page, 'video');
            
            $obj->titleForVideo = htmlspecialchars(substr($urlVideo, stripos($urlVideo, 'aria-label') + 12, stripos($urlVideo, 'длительностью') - (stripos($urlVideo, 'aria-label') + 14))).'.mp4';
            $obj->titleForVideo = str_ireplace(" ", "_", $obj->titleForVideo);
            $urlVideo = stristr($urlVideo, 'aria-label', true);
            
            if (strlen($urlVideo) > 10) {
                $obj = searchVideoVK($obj, $urlVideo);
            }
        } else {
            if ($countRepeats == 1) {
                $obj->typePost = 'GraphImage';
                $obj->typeCell = 'Изображение';
            
                $lpage = stristr($page, 'src_big');
                $lpage = stristr($lpage, 'data', true);
                $obj->urlImage = htmlspecialchars(substr($lpage, stripos($lpage, '"') + 1, stripos($lpage, '|') - (stripos($lpage, '"') + 1)));
            } else {
                $obj->typePost = 'GraphSidecar'; 
                
                $pageImage = stristr($page, 'data-src_big');
                
                for ($i = 0; $i <= $countRepeats - 1; $i++) {
                    array_push($obj->typeEdges, 'GraphImage');
                    array_push($obj->urlVideoEdges, '');
                    $urlImage = htmlspecialchars(substr($pageImage, stripos($pageImage, '"') + 1, stripos($pageImage, '|') - (stripos($pageImage, '"') + 1)));
                    array_push($obj->urlImageEdges, $urlImage);
                    
                    $pageImage = stristr($pageImage, 'data-restriction');
                    $pageImage = stristr($pageImage, 'data-src_big');
                }
                
                $countRepeats = substr_count($page, 'video');
                if ($countRepeats >= 1) {
                    $strVideo = stristr($page, 'video');
                    $strVideo = stristr($strVideo, 'wi_like_wrap', true);
                    
                    $obj->titleForVideo = htmlspecialchars(substr($strVideo, stripos($strVideo, 'aria-label') + 12, stripos($strVideo, 'длительностью') - (stripos($strVideo, 'aria-label') + 14))).'.mp4';
                    $obj->titleForVideo = str_ireplace(" ", "_", $obj->titleForVideo);
                    
                    for ($i = 0; $i <= $countRepeats - 1; $i++) {
                        array_push($obj->typeEdges, 'GraphVideo');
                        
                        $urlVideo = stristr($strVideo, 'video');
                        $urlVideo = stristr($urlVideo, 'aria-label', true);
                        $obj = searchVideoVK($obj, $urlVideo);
                        
                        $strVideo = stristr($strVideo, 'aria-label');
                        $strVideo = stristr($strVideo, 'video');
                    }
                }
            }
        }
        
        if (empty($obj->urlImage) and empty($obj->urlImageEdges)) {
            return error(403);
        }
        
        return $obj;
    }
?>