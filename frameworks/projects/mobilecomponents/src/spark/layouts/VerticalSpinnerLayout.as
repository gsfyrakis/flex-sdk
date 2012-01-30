////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2011 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////
package spark.layouts
{	
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.core.ILayoutElement;
import mx.core.IVisualElement;
import mx.core.mx_internal;

import spark.components.SpinnerList;
import spark.components.supportClasses.GroupBase;
import spark.core.NavigationUnit;

use namespace mx_internal;

[ExcludeClass]

/**
 *  Custom wrapping layout for the SpinnerList
 */ 
public class VerticalSpinnerLayout extends VerticalLayout
{
	public function VerticalSpinnerLayout()
	{
		super();
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private function get totalHeight():Number
	{
		return Math.ceil(target.numElements * rowHeight);
	}
	
	// If true, then when the layout encounters a disabled element, it will scroll past it
	// in ascending index order. If false, then it will scroll in the descending index order
	mx_internal var autoScrollAscending:Boolean = false;
	
	mx_internal static const FORCE_NO_WRAP_ELEMENTS_CHANGE:String = "forceNoWrapElementsChange";
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	//----------------------------------
	//  requestedWrapElements
	//----------------------------------
	
	private var _requestedWrapElements:Boolean = true;
	
	/**
	 *  This is the suggested value for wrapElements. However, the layout might not honor this value
	 *  if there are too few elements to display in the viewable area. 
	 * 
	 *  @default true
	 */
	public function get requestedWrapElements():Boolean
	{
		return _requestedWrapElements;
	}
	
	public function set requestedWrapElements(value:Boolean):void
	{
		if (value == _requestedWrapElements)
			return;
		
		_requestedWrapElements = value;
		target.invalidateSize();
		target.invalidateDisplayList();
	}
	
	/**
	 *  If true, the layout has forced wrapElements to be false
	 */ 
	public var forceNoWrapElements:Boolean = false;
	
	//----------------------------------
	//  wrapElements
	//----------------------------------
	
	/**
	 *  When true, scrolling past the last element will scroll to the first element. 
	 * 
	 *  @default true
	 */
	public function get wrapElements():Boolean
	{
		if (forceNoWrapElements)
			return false;
		else
			return requestedWrapElements;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden methods
	//
	//--------------------------------------------------------------------------
		
	override public function measure():void
	{					
		var preferredWidth:Number = 0;  // max of the elt preferred widths
		
		var element:ILayoutElement;
		var startIndex:int = 0;
        
		var iter:LayoutIterator = new LayoutIterator(target, startIndex);
        
		if (useVirtualLayout)
		{
			if (typicalLayoutElement)
				preferredWidth = typicalLayoutElement.getPreferredBoundsWidth();
		}
		else
		{
            do
            {
                element = iter.getCurrentElement();
                if (element && element.includeInLayout)
                    preferredWidth = Math.max(Math.ceil(element.getPreferredBoundsWidth()), preferredWidth);
                iter.next();
            } 
            while (startIndex != iter.currentIndex); // Loop until we are back at the start
                
		}
		        
		var rowsToMeasure:int = getRowsToMeasure(target.numElements);
		
		// Calculate the height by multiplying the number of elements time the row height
		target.measuredHeight = Math.ceil(rowsToMeasure * Math.max(5, rowHeight));
		target.measuredWidth = preferredWidth;
	}
	
    override public function updateDisplayList(width:Number, height:Number):void
    {
        var element:ILayoutElement;
        var numElements:int = target.numElements;
        
        var oldForceNoWrapElements:Boolean = forceNoWrapElements;
        
        // If there are fewer elements than will fit, we need to set wrapElements = false
        if (requestedWrapElements && (height > numElements * rowHeight))
            forceNoWrapElements = true;
        else
            forceNoWrapElements = false;
        
        if (forceNoWrapElements != oldForceNoWrapElements)
            dispatchEvent(new Event(FORCE_NO_WRAP_ELEMENTS_CHANGE));
        
        var scrollPosition:Number = wrapElements ? 
            normalizeScrollPosition(verticalScrollPosition) : 
            verticalScrollPosition;
		
        var itemIndex:int = Math.floor(scrollPosition / rowHeight);
        var yPos:Number = 0;
        
        var foundLastVisibleElement:Boolean = false;
        var numVisibleElements:int = 0;
        var numVisitedElements:int = 0;
                
        // Translate the vsp to the item index
        if (wrapElements)
        {
            // The top item might only be partially visible. 
            yPos = -(scrollPosition % rowHeight);
        }
        else
        {
            if (!useVirtualLayout)
                itemIndex = 0;
            
            // If itemIndex is either the first or last element
            // then position using -scrollPosition
            if (itemIndex >= numElements)
            {
                itemIndex = numElements - 1;
                yPos = -scrollPosition;
            }
            else if (itemIndex > 0)
            {
                yPos = -(scrollPosition % rowHeight);
            }
            else // itemIndex == 0
            {
                yPos = -scrollPosition;
            }
        }			
        
        // Start at the top index
        var iter:LayoutIterator = new LayoutIterator(target, itemIndex);
        
        do
        {
            element = iter.getCurrentElement();
            if (element && element.includeInLayout)
            {
                numVisitedElements++;
                
                element.setLayoutBoundsSize(width, rowHeight);
                element.setLayoutBoundsPosition(0, yPos);
                
                yPos += rowHeight;
                
                // If we are using virtual layout, only size and position 
                // the visible elements
                if (yPos > height && !foundLastVisibleElement)
                {
                    foundLastVisibleElement = true;
                    // Keep track of the number of elements visible in the viewing area
                    numVisibleElements = numVisitedElements;
                    if (useVirtualLayout)
                        break;
                }
            }
            
            // Make sure to not wrap if wrapElements = false
            if (!wrapElements && iter.currentIndex == numElements - 1)
                break;
            
            iter.next();
        } 
        while (itemIndex != iter.currentIndex)
        
        setRowCount(numVisibleElements);
        
        // Set the contentWidth and contentHeight
        target.setContentSize(target.width, Math.ceil(numElements * rowHeight));
    }

	override public function getElementBounds(index:int):Rectangle
	{		
		return new Rectangle(0, index * rowHeight, target.measuredWidth, rowHeight); 
	}
	
	//--------------------------------------------------------------------------
	//
	//  Overridden scroll methods
	//
	//--------------------------------------------------------------------------
	
	override public function updateScrollRect(w:Number, h:Number):void
	{
		var g:GroupBase = target;
		if (!g)
			return;
		
		// Instead of moving the scrollRect position, we reposition the elements
		if (clipAndEnableScrolling)
			g.scrollRect = new Rectangle(0, 0, w, h);
		else
			g.scrollRect = null;
	}
	
	override protected function scrollPositionChanged():void
	{
		if (target)
		{
			target.invalidateDisplayList();
			setIndexInView(0, target.numElements - 1);
		}
	}
	
	override public function getHorizontalScrollPositionDelta(navigationUnit:uint):Number
	{
		return 0;
	}
	
	override public function getVerticalScrollPositionDelta(navigationUnit:uint):Number
	{		
		return 0;
	}
	
	override mx_internal function getElementNearestScrollPosition(
		position:Point,elementComparePoint:String = "center"):int
	{
		
		var index:int = Math.floor(position.y / rowHeight); // may be larger than numElements to indicate wrapping
		
		var element:ILayoutElement;
		var startIndex:int = index % target.numElements;
        var distance:int = 0;
        var direction:int = autoScrollAscending ? 1 : -1;
		if (startIndex < 0)
            startIndex += target.numElements;
		
		// If the element at index % numElements) is not selectable, find the nearest one that is              
        var iter:LayoutIterator = new LayoutIterator(target, startIndex);
        
        while (Math.abs(distance) <= (target.numElements / 2) + 1)
        {
            // Try searching in one direction
            iter.currentIndex = startIndex + distance * direction;
            element = iter.getCurrentElement();    
            
            if (isElementEnabled(element))
                break;
            
            if (distance != 0)
            {
                // Flip the direction
                direction *= -1;
                
                // Try searching in the other direction
                iter.currentIndex = startIndex + distance * direction;
                element = iter.getCurrentElement();    
                
                if (isElementEnabled(element))
                    break;
                
                // Flip the direction back
                direction *= -1;
            }
            
            distance++;
        }
		
		// If we don't allow wrapping, then cap the max index
		if(!wrapElements)
			index = Math.max(0, Math.min(index, target.numElements - 1));
		
		return index + distance * direction;
	}
		
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Returns the index of the element intersected by the vertical center of the viewable area
	 */ 
	public function getIndexAtVerticalCenter():int
	{
        var midY:Number = target.getLayoutBoundsHeight() / 2;
		var vsp:Number = wrapElements ? normalizeScrollPosition(verticalScrollPosition + midY) : verticalScrollPosition + midY;
        
		return getElementNearestScrollPosition(new Point(0, vsp), "center"); 
	}
    
	/**
	 *  Takes an index between 0 and numElements and returns the index taking wrapping into account
	 */
	public function getUnwrappedElementIndex(index:int):int
	{
		// find the non-wrapped (i.e. non-modulo) index of the element on screen
		if (wrapElements)
		{
			var wrapCount:int = Math.floor(verticalScrollPosition / totalHeight);
			index += wrapCount * target.numElements;
			
			var firstVisibleItem:int = (verticalScrollPosition ) / rowHeight;
			if (index < firstVisibleItem)
				index += target.numElements;
		}
		
		return index;
	}
    
	// Helper function to calculate the non-wrapped, non-negative scroll position
	private function normalizeScrollPosition(vsp:int):int
	{
		// Normalize the scrollPosition
 		if (!isNaN(totalHeight))
		{
			vsp %= totalHeight;
			
			if (vsp < 0)
				vsp += totalHeight;
		}
		
		return vsp;
	}
    
    // Helper function to return whether an element is enabled or not
    private function isElementEnabled(element:Object):Boolean
    {
        // Element is false if it was a simple type and didn't survive the 
        // casting as an object
        try
        {
            if (!element || element["enabled"] == undefined || element["enabled"] == true)
                return true;
        }
        catch (e:Error)
        {
            
        }
       
        
        return false;
    }
}
}

////////////////////////////////////////////////////////////////////////////////
//
//  Helper class: LayoutIterator
//
////////////////////////////////////////////////////////////////////////////////

import mx.core.ILayoutElement;

import spark.components.supportClasses.GroupBase;

/**
 *  Layout helper class. Iterates over a set of items. The iterator can optionally wrap around the 
 *  end of the set back to the beginning of the set.  
 */ 
class LayoutIterator 
{
	/**
	 *  Constructor. Takes a layout target and the starting index for the iterator
	 *  
	 *  @param target The GroupBase target that contains the elements
	 *  @param index The starting index for the iterator  
	 */ 
	public function LayoutIterator(target:GroupBase, index:int = 0):void
	{
		totalElements = target.numElements;
		_target = target;
		_curIndex = index;
		_useVirtual = _target.layout.useVirtualLayout;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Variables
	//
	//--------------------------------------------------------------------------
	
	private var _curIndex:int;
	private var _target:GroupBase;
	private var _useVirtual:Boolean;
	private var totalElements:int;
	
	//--------------------------------------------------------------------------
	//
	//  Properties
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Returns the index that the iterator is currently pointing
	 */ 
	public function get currentIndex():int
	{
		return _curIndex;
	}
    
    public function set currentIndex(value:int):void
    {
        _curIndex = value;
    }
		
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	/**
     *  Get the element at the currentIndex 
     */ 
    public function getCurrentElement():ILayoutElement
    {
        return _useVirtual ? _target.getVirtualElementAt(_curIndex) :
                             _target.getElementAt(_curIndex);
    }
    
    /**
     *  Move the currentIndex to the next index. If the currentIndex is at
     *  the last index, then it is set to the first index. 
     */
    public function next():int
    {
        if (_curIndex == totalElements - 1)
            _curIndex = 0;
        else
            _curIndex++;
        
        return _curIndex;
    }
    
    /**
     *  Move the currentIndex to the previous index. If the currentIndex is at
     *  the fist index, then it is set to the last index. 
     */
    public function prev():int
    {
        if (_curIndex == 0)
            _curIndex = totalElements - 1;
        else
            _curIndex--;
        
        return _curIndex;
    }

}