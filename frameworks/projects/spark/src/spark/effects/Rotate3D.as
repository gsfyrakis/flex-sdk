////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2009 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package spark.effects
{
import mx.core.mx_internal;
import mx.effects.IEffectInstance;

import spark.effects.animation.MotionPath;
import spark.effects.supportClasses.AnimateTransformInstance;

use namespace mx_internal;

//--------------------------------------
//  Excluded APIs
//--------------------------------------

[Exclude(name="motionPaths", kind="property")]

/**
 *  The Rotate3D class rotate a target object
 *  in three dimensions around the x, y, or z axes. 
 *  The rotation occurs around the transform center of the target. 
 * 
 *  <p>Like all AnimateTransform-based effects, this effect only works on subclasses
 *  of UIComponent and GraphicElement, as these effects depend on specific
 *  transform functions in those classes. 
 *  Also, transform effects running in parallel on the same target run as a single
 *  effect instance
 *  Therefore, the transform effects share the transform center 
 *  set by any of the contributing effects.</p>
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Rotate3D&gt;</code> tag
 *  inherits all of the tag attributes of its superclass,
 *  and adds the following tag attributes:</p>
 *
 *  <pre>
 *  &lt;mx:Rotate3D
 *    <b>Properties</b>
 *    id="ID"
 *    applyChangesPostLayout="true"
 *    angleXFrom="no default"
 *    angleXTo="no default"
 *    angleYFrom="no default"
 *    angleYTo="no default"
 *    angleZFrom="no default"
 *    angleZTo="no default"
 *  /&gt;
 *  </pre>
 *
 *  @langversion 3.0
 *  @playerversion Flash 10
 *  @playerversion AIR 1.5
 *  @productversion Flex 4
 */       
public class Rotate3D extends AnimateTransform
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
     *  @param target The Object to animate with this effect.
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public function Rotate3D(target:Object=null)
    {
        super(target);
        applyLocalProjection = true;
        instanceClass = AnimateTransformInstance;
        applyChangesPostLayout = true;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  applyChangesPostLayout
    //----------------------------------
    [Inspectable(category="General")]
    /** 
     *  @copy AnimateTransform#applyChangesPostLayout
     *  The default value for this property is true for 3D effects,
     *  because the Flex layout system ignores 3D transformation properties.
     *
     *  @default true
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    override public function get applyChangesPostLayout():Boolean
    {
        return super.applyChangesPostLayout;
    }
    
    //----------------------------------
    //  angleXFrom
    //----------------------------------

    [Inspectable(category="General")]

    /** 
     *  The starting angle of rotation of the target object around
     *  the x axis, expressed in degrees.
     *  Valid values range from 0 to 360.
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var angleXFrom:Number;

    //----------------------------------
    //  angleXTo
    //----------------------------------

    [Inspectable(category="General")]

    /** 
     *  The ending angle of rotation of the target object around
     *  the x axis, expressed in degrees.
     *  Values can be either positive or negative.
     *
     *  <p>If the value of <code>angleTo</code> is less
     *  than the value of <code>angleFrom</code>,
     *  the target rotates in a counterclockwise direction.
     *  Otherwise, it rotates in clockwise direction.
     *  If you want the target to rotate multiple times,
     *  set this value to a large positive or small negative number.</p>
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var angleXTo:Number;
                
    //----------------------------------
    //  angleYFrom
    //----------------------------------

    [Inspectable(category="General")]

    /** 
     *  The starting angle of rotation of the target object around
     *  the y axis, expressed in degrees.
     *  Valid values range from 0 to 360.
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var angleYFrom:Number;

    //----------------------------------
    //  angleYTo
    //----------------------------------

    [Inspectable(category="General")]

    /** 
     *  The ending angle of rotation of the target object around
     *  the y axis, expressed in degrees.
     *  Values can be either positive or negative.
     *
     *  <p>If the value of <code>angleTo</code> is less
     *  than the value of <code>angleFrom</code>,
     *  the target rotates in a counterclockwise direction.
     *  Otherwise, it rotates in clockwise direction.
     *  If you want the target to rotate multiple times,
     *  set this value to a large positive or small negative number.</p>
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var angleYTo:Number;

    //----------------------------------
    //  angleZFrom
    //----------------------------------

    [Inspectable(category="General")]

    /** 
     *  The starting angle of rotation of the target object around
     *  the z axis, expressed in degrees.
     *  Valid values range from 0 to 360.
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var angleZFrom:Number;

    //----------------------------------
    //  angleZTo
    //----------------------------------

    [Inspectable(category="General")]

    /** 
     *  The ending angle of rotation of the target object around
     *  the z axis, expressed in degrees.
     *  Values can be either positive or negative.
     *
     *  <p>If the value of <code>angleTo</code> is less
     *  than the value of <code>angleFrom</code>,
     *  the target rotates in a counterclockwise direction.
     *  Otherwise, it rotates in clockwise direction.
     *  If you want the target to rotate multiple times,
     *  set this value to a large positive or small negative number.</p>
     * 
     *  @langversion 3.0
     *  @playerversion Flash 10
     *  @playerversion AIR 1.5
     *  @productversion Flex 4
     */
    public var angleZTo:Number;
    
    /**
     * @private
     */
    override public function createInstance(target:Object = null):IEffectInstance
    {
        motionPaths = new Vector.<MotionPath>();
        return super.createInstance(target);
    }
                        
    /**
     * @private
     */
    override protected function initInstance(instance:IEffectInstance):void
    {
        if (!applyChangesPostLayout)
        {
            addMotionPath("rotationX", angleXFrom, angleXTo);
            addMotionPath("rotationY", angleYFrom, angleYTo);
            addMotionPath("rotationZ", angleZFrom, angleZTo);
        }
        else
        {
            addPostLayoutMotionPath("postLayoutRotationX", angleXFrom, angleXTo);
            addPostLayoutMotionPath("postLayoutRotationY", angleYFrom, angleYTo);
            addPostLayoutMotionPath("postLayoutRotationZ", angleZFrom, angleZTo);
        }
        super.initInstance(instance);
    }    
}
}