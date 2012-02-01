////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2003-2006 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package spark.primitives
{

import flash.events.EventDispatcher;
import flash.display.Graphics;
import flash.geom.Rectangle;
import flash.geom.Point;
import flash.geom.Matrix;
import mx.utils.MatrixUtil;
import spark.primitives.supportClasses.FilledElement;

/**
 *  The Ellipse class is a filled graphic element that draws an ellipse.
 *  To draw the ellipse, this class calls the <code>Graphics.drawEllipse()</code> 
 *  method.
 *  
 *  @see flash.display.Graphics
 *  
 *  @includeExample examples/EllipseExample.mxml
 *  
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */
public class Ellipse extends FilledElement
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor. 
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function Ellipse()
    {
        super();
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------
    
    /**
     *  @inheritDoc
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    override protected function drawElement(g:Graphics):void
    {
        g.drawEllipse(drawX, drawY, width, height);
    }
    
    /**
     *  @private
     */
    override protected function transformWidthForLayout(width:Number,
                                                        height:Number,
                                                        postTransform:Boolean = true):Number
    {
        if (postTransform)
        {
            var m:Matrix = computeMatrix();
            if (m)
                width = MatrixUtil.getEllipseBoundingBox(width / 2, height / 2, width / 2, height / 2, m).width;
        }

        // Take stroke into account
        return width + getStrokeExtents().x;
    }

    /**
     *  @private
     */
    override protected function transformHeightForLayout(width:Number,
                                                         height:Number,
                                                         postTransform:Boolean = true):Number
    {
        if (postTransform)
        {
            var m:Matrix = computeMatrix();
            if (m)
                height = MatrixUtil.getEllipseBoundingBox(width / 2, height / 2, width / 2, height / 2, m).height;
        }

        // Take stroke into account
        return height + getStrokeExtents().y;
    }

    /**
     *  @private
     */
    override public function getLayoutBoundsX(postTransform:Boolean = true):Number
    {
        var stroke:Number = -getStrokeExtents(postTransform).x * 0.5;
        
        if (postTransform)
        {
            var m:Matrix = computeMatrix();
            if (m)
                return stroke + MatrixUtil.getEllipseBoundingBox(width / 2, height / 2, width / 2, height / 2, m).x;
        }
        
        return stroke + this.x;
    }

    /**
     *  @private
     */
    override public function getLayoutBoundsY(postTransform:Boolean = true):Number
    {
        var stroke:Number = - getStrokeExtents(postTransform).y * 0.5;

        if (postTransform)
        {
            var m:Matrix = computeMatrix();
            if (m)
                return stroke + MatrixUtil.getEllipseBoundingBox(width / 2, height / 2, width / 2, height / 2, m).y;
        }

        return stroke + this.y;
    }
}
}
