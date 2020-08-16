<?php
    $obj = new resultSearch;

    class YouTubeDownloader {
        private $video_id;
        private $video_title;
        private $video_url; 
        
        private $link_pattern; 
         
        public function __construct(){ 
            $this->link_pattern = "/^(?:http(?:s)?:\/\/)?(?:www\.)?(?:m\.)?(?:youtu\.be\/|youtube\.com\/(?:(?:watch)?\?(?:.*&)?v(?:i)?=|(?:embed)\/))([^\?&\"'>]+)/"; 
        } 
        
        public function setUrl($url){ 
            $this->video_url = $url; 
        } 
         
        public function extractVideoId($video_url){ 
            $parsed_url = parse_url($video_url);
            if ($parsed_url["path"] == "youtube.com/watch") { 
                $this->video_url = "https://www.".$video_url; 
            } else if ($parsed_url["path"] == "www.youtube.com/watch") { 
                $this->video_url = "https://".$video_url; 
            }
             
            if(isset($parsed_url["query"])){ 
                $query_string = $parsed_url["query"];
                parse_str($query_string, $query_arr); 
                if(isset($query_arr["v"])){ 
                    return $query_arr["v"]; 
                } 
            }    
        } 
        
        private function getVideoInfo(){
            global $obj;
            
            $video_id = $this->extractVideoId($this->video_url);
            $obj->idVideo = $video_id;
            
            return file_get_contents("https://www.youtube.com/get_video_info?video_id=".$video_id."&cpn=CouQulsSRICzWn5E&eurl&el=adunit"); 
        } 
        
        public function getDownloader($url){
            if(preg_match($this->link_pattern, $url)){ 
                return $this; 
            } 
            return false; 
        } 
         
        public function getVideoDownloadLink(){ 
            global $obj;
            parse_str($this->getVideoInfo(), $data); 
            $videoData = json_decode($data['player_response'], true);
            
            $videoDetails = $videoData['videoDetails'];
            
            $obj->titlePost = $videoDetails["title"];
            $obj->countView = $videoDetails["viewCount"].' ';
            $obj->nicknameUser = (string)$videoDetails["author"].' ';
            $obj->idUser = $videoDetails["channelId"].' ';
            $obj->textPost = $videoDetails["shortDescription"];
            $obj->urlImage = "https://i.ytimg.com/vi/$obj->idVideo/maxresdefault.jpg";
              
            $videoFileName = strtolower(str_replace(' ', '_', $videoDetails['title'])).'.mp4';
            $fileName = preg_replace('/[^A-Za-z0-9.\_\-]/', '', basename($videoFileName)); 
            $obj->titleForVideo = $fileName;
            
            $streamingData = $videoData['streamingData'];
            $streamingDataFormats = $streamingData['formats'];
            for($i = 0; $i < count($streamingDataFormats); $i++) {
                switch ($streamingDataFormats[$i]['qualityLabel']) {
                    case '1080p':
                        $obj->urlForVideo1080p = $streamingDataFormats[$i]['url'];
                        break;
                    case '720p':
                        $obj->urlForVideo720p = $streamingDataFormats[$i]['url'];
                        break;
                    case '480p':
                        $obj->urlForVideo480p = $streamingDataFormats[$i]['url'];
                        break;
                    case '360p':
                        $obj->urlForVideo360p = $streamingDataFormats[$i]['url'];
                        break;
                    case '240p':
                        $obj->urlForVideo240p = $streamingDataFormats[$i]['url'];
                        break;
                }
            }
            
            return $obj;
        } 
          
        public function hasVideo(){ 
            $valid = true; 
            parse_str($this->getVideoInfo(), $data); 
            if($data["status"] == "fail"){ 
                $valid = false; 
            }  
            return $valid; 
        } 
          
    }

    function searchYoutube($link) {
        $obj = new resultSearch;
        $obj->urlPost = $link;
        
        $handler = new YouTubeDownloader();
        $youtubeURL = $link;
        
        if(!empty($youtubeURL) && !filter_var($youtubeURL, FILTER_VALIDATE_URL) === false) {
            $downloader = $handler->getDownloader($youtubeURL); 
             
            $downloader->setUrl($youtubeURL); 
             
            if($downloader->hasVideo()){
                $obj = $downloader->getVideoDownloadLink();
            } else {
                return error(403);
            } 
        } else { 
            return error(403);
        } 
        
        $obj->typePost = 'GraphVideo';
        $obj->typeCell = 'Видео';
        
        //while(empty($obj->urlAvatar)) {
            $ch=curl_init(); 
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
            curl_setopt($ch, CURLOPT_TIMEOUT, 25);
            curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 30);
            curl_setopt($ch, CURLOPT_HTTPPROXYTUNNEL, 1); 
            curl_setopt($ch, CURLOPT_FAILONERROR, true);
            curl_setopt($ch, CURLOPT_USERAGENT, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101206 Ubuntu/10.10 (maverick) Firefox/3.6.13'); 
            curl_setopt($ch, CURLOPT_URL, $link);
            $page = curl_exec($ch); 
            curl_close($ch);
            
            $lpage = stristr($page, 'videoOwnerRenderer');
            $lpage = stristr($lpage, 'title', true);
            $lpage = stristr($lpage, 'url');
            $lpage = stristr($lpage, 'width', true);
            $obj->urlAvatar = htmlspecialchars(substr($lpage, stripos($lpage, ':') + 2, stripos($lpage, ',') - (stripos($lpage, ':') + 3)));
            $obj->urlAvatar = str_ireplace("s48", "s176", $obj->urlAvatar); 
            
            $lpage = stristr($page, 'likeStatus');
            $lpage = stristr($lpage, 'dateText', true);
            $lpage = stristr($lpage, 'tooltip');
            
            $obj->countLikes = htmlspecialchars(substr($lpage, stripos($lpage, ':') + 2, stripos($lpage, '/') - (stripos($lpage, ':') + 2))).' ';
            $obj->countDislikes = htmlspecialchars(substr($lpage, stripos($lpage, '/') + 2, stripos($lpage, '}') - (stripos($lpage, '/') + 3))).' ';
            
            $lpage = stristr($page, 'subscriberCountText');
            $lpage = stristr($lpage, 'trackingParams', true);
            $lpage = stristr($lpage, '"text');
            
            $obj->countSubscrite = htmlspecialchars(substr($lpage, stripos($lpage, ':') + 2, stripos($lpage, '}') - (stripos($lpage, ':') + 3)));
            $obj->countSubscrite = str_ireplace(" подписчиков", "", $obj->countSubscrite).' ';    
        //}
        
        if (empty($obj->urlForVideo240p) && empty($obj->urlForVideo360p) && empty($obj->urlForVideo480p) && empty($obj->urlForVideo7200p) && empty($obj->urlForVideo720p60) &&
            empty($obj->urlForVideo1080p) && empty($obj->urlForVideo1080p60) && empty($obj->urlForVideo1440p) && empty($obj->urlForVideo1440p60) &&
            empty($obj->urlForVideo2160p) && empty($obj->urlForVideo2160p60)) {
            return error(403);
        }
        
        return $obj;
    }
?>