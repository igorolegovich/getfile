<?php
    require_once('network/instagram.php');
    require_once('network/youtube.php');
    require_once('network/vk.php');
    require_once('network/facebook.php');

    class resultSearch
    {
        // Общая информация
        var $date;
        var $time;
        
        var $urlPost;
        var $titlePost;
        var $textPost;
        
        var $nicknameUser;
        var $urlAvatar;
        
        var $countLikes;
        var $countDislikes;
        var $countSubscrite;
        var $countComment;
        var $countView;
        
        // Инфорамция для фотографий
        var $urlImage;
        
        // Информация для видео
        var $urlForVideo1080p;
        var $urlForVideo720p;
        var $urlForVideo480p;
        var $urlForVideo360p;
        var $urlForVideo240p;
        
        // Информация спец. для Instagram
        var $typePost;
        var $typeCell;
        var $typeEdges = array();
        var $urlImageEdges = array();
        var $urlVideoEdges = array();
        
        // Информация спец. для Youtube
        var $idUser;
        var $titleForVideo;
        var $idVideo;
    }

    $link = $_GET['link'];
    $mobile = $_GET['mobile']; 
    $obj = new resultSearch;
    
    $countSearch = 0;
    
    if (stripos($link, 'www.instagram.com') and strlen($link) > 25) {
        $obj = searchInstagram($link);
    } else {
        if ( stripos($link, 'youtu.be') or (stripos($link, 'www.youtube.com') and strlen($link) > 24) ) {
            $link = str_ireplace("youtu.be/", "www.youtube.com/watch?v=", $link);
            $obj = searchYoutube($link);
        } else {
            if (stripos($link, 'vk.com') and strlen($link) > 15) {
                $obj = searchVK($link);
            } else {
                if (stripos($link, 'www.facebook.com') and strlen($link) > 25) {
                    $obj = searchFacebook($link);
                } else {
                    $obj = error('400');
                }
            }
        }
    }
    
    function error($code) {
        $obj = new resultSearch;
        
        $error = true;
        $obj->urlPost = $_GET['link'];
        $obj->titlePost = ' '.$code.' ';
        switch ($code) {
            case '400':
                $obj->textPost = 'Неверный запрос';
            break;
            case '403':
                $obj->textPost = 'Ваш запрос невозможно обработать в настоящий момент.
Попробуйте позже.';
            break;
            case '404':
                $obj->textPost = 'Страница не найдена';
            break;
            case '503':
                $obj->textPost = 'Сервер не доступен';
            break;
        }
        
        return $obj;
    }
    
    if ($mobile) {
        print_r(json_encode($obj, JSON_UNESCAPED_UNICODE));
    } else {
        echo '<pre>'.json_encode($obj, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_NUMERIC_CHECK).'</pre>';
    }
?>