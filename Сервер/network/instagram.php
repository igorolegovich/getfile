<?php
    function searchInstagram($link) {
        $obj = new resultSearch;
        $obj->urlPost = $link;
        // https://hidemy.name/ru/proxy-list/?maxtime=500&ports=8080&type=hs&anon=4#list
        
        $ip = '176.9.119.170:8080';
        /*
        $ch=curl_init(); 
        //curl_setopt($ch, CURLOPT_PROXY, $ip); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_TIMEOUT, 25);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
        curl_setopt($ch, CURLOPT_HTTPPROXYTUNNEL, 1); 
        curl_setopt($ch, CURLOPT_FAILONERROR, true);
        curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13'); 
        curl_setopt($ch, CURLOPT_URL, $link.'?__a=1');
        $html = curl_exec($ch); 
        curl_close($ch);
        */
        $ch = curl_init($link);
        curl_setopt($ch, CURLOPT_PROXY, $ip);
        curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)"); 
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($ch, CURLOPT_HEADER, true);
        $html = curl_exec($ch);
        curl_close($ch);
        
        if ($html == '') {
            return error('503');
        }
        
        if (stristr($html, '__typename') == false) {
            return error('404');
        }
        
        $content = explode("window._sharedData = ", $html)[1];
        $content = explode(";</script>", $content)[0];
        $data    = json_decode($content, true);
        $PostData = $data['entry_data']['PostPage'][0]['graphql']['shortcode_media'];

        //echo '<pre>';
        //print_r($PostData);
        //echo '</pre>';
        
        $obj->typePost = $PostData['__typename'];
        switch ($obj->typePost) {
            case 'GraphImage':
                $obj->typeCell = 'Изображение';
                
                $obj->urlImage = $PostData['display_url'];
                break;
            case 'GraphSidecar':
                $edges = $PostData['edge_sidecar_to_children']['edges'];
                
                for($i = 0; $i <= count($edges) - 1; $i++) {
                    array_push($obj->typeEdges, $edges[$i]['node']['__typename']);
                    array_push($obj->urlImageEdges, $edges[$i]['node']['display_url']);
                    
                    if ($obj->typeEdges[$i] == 'GraphVideo') {
                        array_push($obj->urlVideoEdges, $edges[$i]['node']['video_url']);
                    } else {
                        array_push($obj->urlVideoEdges, '');
                    }
                }
                break;
            case 'GraphVideo':
                $obj->typeCell = 'Видео';
                $obj->urlImage = $PostData['display_url'];
                $obj->urlForVideo1080p = $PostData['video_url'];
                $obj->countView = (string)$PostData['video_view_count'].' ';
                break;
        }
        
        $obj->countComment = $PostData['edge_media_to_parent_comment']['count'].' ';
        $obj->countLikes = $PostData['edge_media_preview_like']['count'].' ';
        $obj->textPost = $PostData['edge_media_to_caption']['edges'][0]['node']['text'].' ';
        
        $profile = $PostData['owner'];
        $obj->urlAvatar = $profile['profile_pic_url'];
        $obj->nicknameUser = $profile['username'];
        $obj->idUser = $profile['id'].' ';
        $obj->countSubscrite = (string)$profile['edge_followed_by']['count'];
        
        return $obj;
    }
?>