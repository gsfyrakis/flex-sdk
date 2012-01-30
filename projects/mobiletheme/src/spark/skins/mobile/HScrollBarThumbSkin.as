////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2010 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package spark.skins.mobile
{

import flash.display.Graphics;

import spark.components.Button;
import spark.skins.mobile.supportClasses.MobileSkin;

public class HScrollBarThumbSkin extends MobileSkin 
{
    
    public function HScrollBarThumbSkin()
    {
        super();
    }
    
    public var hostComponent:Button;
    
    override public function getExplicitOrMeasuredWidth():Number
    {
        return 8;
    }
    
    override public function getExplicitOrMeasuredHeight():Number
    {
        return 8;
    }
    
    override protected function measure():void
    {
        measuredWidth = 8;
        measuredHeight = 8;
    }
    
    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
    {
        var g:Graphics = graphics;
        
        var chromeColor:uint = getStyle("chromeColor");
        g.clear();
        g.lineStyle(1, chromeColor);
        g.beginFill(chromeColor, 0.5);
        g.drawRoundRect(0.5, 0.5, unscaledWidth, unscaledHeight, 7, 7);
        g.endFill();
    }
    
}
}