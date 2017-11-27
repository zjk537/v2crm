<?php
namespace Home\Controller;

phpinfo(); exit();

use Common\BarCode\AuthBarCode;
use Common\BarCode\FontBarCode;
use Common\BarCode\ColorBarCode;
use Common\BarCode\DrawingBarCode;

class BarCodeController 
{
    public function index()
    {
        $text =I('get.Code');
        $Type    = 'Code128';
        $BarCode = AuthBarCode::getInstance($Type);
        $Font = new FontBarCode(APP_PATH . '/Common/BarCode/font/Arial.ttf', 18);
        $color_black = new ColorBarCode(0, 0, 0);
        $color_white = new ColorBarCode(255, 255, 255);
        $BarCode->setScale(2); // Resolution
        $BarCode->setThickness(35); // Thickness
        $BarCode->setForegroundColor($color_black); // Color of bars
        $BarCode->setBackgroundColor($color_white); // Color of spaces
        $BarCode->setFont($Font); // Font (or 0)
        $text =$text?$text:strtotime(date("Y-m-d H:i:s")) . rand(10, 99); //条形码将要数据的内容
        $BarCode->parse($text);
        $drawing = new DrawingBarCode('', $color_white);
        $drawing->setBarcode($BarCode);
        $drawing->draw();
        // Header that says it is an image (remove it if you save the barcode.bak to a file)
        header('Content-Type: image/png');
        // Draw (or save) the image into PNG format.
        $drawing->finish(DrawingBarCode::IMG_FORMAT_PNG);
    }
}