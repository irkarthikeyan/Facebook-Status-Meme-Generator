use GD;

$full_image_width = 800;
$full_image_height = 600;
$full_image = new GD::Image($full_image_width,$full_image_height);
$dp_startx = 50;
$dp_starty = 50;

$full_image_startx = 50;
$full_image_starty = 120;

$white = $full_image->colorAllocate(255,255,255);
$blue = $full_image->colorAllocate(59,89,152);
$grey = $full_image->colorAllocate(192,192,192);
$light_blue = $full_image->colorAllocate(230,242,255);
$black = $full_image->colorAllocate(80,80,80);

sub draw_dp{
	$image_file = $_[0];
	$dp = GD::Image->newFromJpeg($image_file);
	($width, $height) = $dp->getBounds();
	$dp_resx = 50;
	$dp_resy = 50;
	$full_image->copyResampled($dp,$dp_startx,$dp_starty,0,0,$dp_resx,$dp_resy,$width,$height);
}

sub draw_dp_forComment{
        $image_file = $_[0];
        $dp = GD::Image->newFromJpeg($image_file);
        ($width, $height) = $dp->getBounds();
        $dp_resx = 34;
        $dp_resy = 34;
        $full_image->copyResampled($dp,$full_image_startx+3,$full_image_starty+3,0,0,$dp_resx,$dp_resy,$width,$height);
}

sub draw_dp_name{
	$name = $_[0];
	$full_image->string(gdMediumBoldFont,110,57,$name,$blue);
	$full_image->string(gdSmallFont,110,70,"5 hours ago",$grey);
}

sub draw_like_image{
	$like = "./like.jpeg";
	$like_image = GD::Image->newFromJpeg($like);
	$full_image->copyResampled($like_image,$full_image_startx+2,$full_image_starty+5,0,0,15,13,15,13);
}

sub draw_like_image_forComment{
	$startx = $_[0];
	$starty = $_[1];
	$like = "/Users/rkarth/Desktop/like.jpeg";
	$like_image = GD::Image->newFromJpeg($like);
	$full_image->copyResampled($like_image,$startx,$starty,0,0,15,13,15,13);
}

sub draw_status{
	$status = $_[0];
	$current_startx = 50;
	$current_starty = 120;
	$runningIndex = 0;
	$line = 1;
	for($index = 0; $index<length($status); $index++){
		$full_image->string(gdMediumBoldFont,$current_startx+$runningIndex,$current_starty,substr($status,$index,1),$black);
                if($current_startx+$runningIndex >= 740){
			if($line == 3){
				last;
			}
                        $current_starty = $current_starty + 10;
                        $current_startx = 50;
                        $runningIndex = -5;
			$line = $line + 1;
                }
                $runningIndex = $runningIndex + 5;
	}
	$full_image_startx = 50;
	$full_image_starty = 120+($line*10)+10;
}

sub draw_filled_rectangle{
	$startx = $_[0];
	$starty = $_[1];
	$endy = $starty+20;
	$full_image->filledRectangle($startx,$starty,750,$endy,$light_blue); 
}

sub draw_filled_rectangle_forComment{
        $startx = $_[0];
        $starty = $_[1];
        $endy = $starty+40;
        $full_image->filledRectangle($startx,$starty,750,$endy,$light_blue);
}

sub draw_comment{
	$name = $_[0];
	$comment = $_[1];
	$likes = $_[2];
	$temp = $full_image_startx+39;
	$runningIndex = 0;
	$currentx = $full_image_startx+39;
	$currenty = $full_image_starty+3;
	for($index = 0; $index<length($name); $index++){
		$full_image->string(gdMediumBoldFont,$currentx+$runningIndex,$currenty,substr($name,$index,1),$blue);
		$runningIndex = $runningIndex + 7;
	}
	$line = 1;
	$runningIndex = $runningIndex + 5;
	for($index = 0; $index<length($comment);$index++){
		$full_image->string(gdSmallFont,$currentx+$runningIndex,$currenty,substr($comment,$index,1),$black);		
		if($currentx+$runningIndex >= 740){
			if($line == 2){
				last;
			}
                        $currenty = $currenty + 10;
                        $currentx = $temp;
                        $runningIndex = -5;
			$line = $line + 1;
                }
                $runningIndex = $runningIndex + 5;
	}

	$currenty = $full_image_starty+25;
	$currentx = $full_image_startx+39;
	$time_text = "5 hours ago .  ";
	$like_text = "Like . ";
	$runningIndex = 0;
	for($index = 0; $index<length($time_text);$index++){
		$full_image->string(gdSmallFont,$currentx+$runningIndex,$currenty,substr($time_text,$index,1),$grey);
		$runningIndex = $runningIndex + 5;
	}
	for($index = 0; $index<length($like_text);$index++){
		$full_image->string(gdSmallFont,$currentx+$runningIndex,$currenty,substr($like_text,$index,1),$blue);
                $runningIndex = $runningIndex + 5;
	}
	&draw_like_image_forComment($currentx+$runningIndex+5,$currenty);
	$full_image->string(gdSmallFont,$currentx+$runningIndex+23,$currenty,$likes,$blue);
	
}

$dp_path = "./dp.jpg";
&draw_dp($dp_path);
$name = "Karthikeyan Ravi";
&draw_dp_name($name);
$full_image->line(50,110,750,110,$grey);
&draw_status("This is test status. Testing. Testing. Testing. Testing. Testing. Testing . Testing.Testing. Testing. Testing. Testing. Testing. Testing . Testing. ");

&draw_filled_rectangle($full_image_startx, $full_image_starty);
$full_image->string(gdSmallFont,$full_image_startx+2,$full_image_starty+5,"Like . Comment . Share . Unfollow Post . Promote",$blue);
$full_image_starty = $full_image_starty+25;

&draw_filled_rectangle($full_image_startx,$full_image_starty);
&draw_like_image();
$full_image->string(gdSmallFont,73,$full_image_starty+5,"Vinay Kumar Kotakonda, Nagarajan GV, Senthil JJ and 7 others like this.",$blue);
$full_image_starty = $full_image_starty+25;

&draw_filled_rectangle_forComment($full_image_startx,$full_image_starty);
&draw_dp_forComment($dp_path);
&draw_comment("Sachin Tendulkar","ttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt",7);

$full_image_starty = $full_image_starty + 45;

&draw_filled_rectangle_forComment($full_image_startx,$full_image_starty);
&draw_dp_forComment($dp_path);
&draw_comment("AR Rahman","Good work",9);

open(PICTURE, ">./outputKarthiTesting.png") or die("Cannot open file for writing");

binmode PICTURE;

print PICTURE $full_image->jpeg;
close PICTURE;

