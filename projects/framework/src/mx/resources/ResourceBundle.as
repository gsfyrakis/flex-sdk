////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

package mx.resources
{

import flash.system.ApplicationDomain;

import mx.core.mx_internal;
import mx.utils.StringUtil;

use namespace mx_internal;

/**
 *  Provides an implementation of the IResourceBundle interface.
 *  The IResourceManager and IResourceBundle interfaces work together
 *  to provide internationalization support for Flex applications.
 *
 *  <p>A Flex application typically has multiple instances of this class,
 *  all managed by a single instance of the ResourceManager class.
 *  It is possible to have ResourceBundle instances for multiple locales,
 *  one for each locale. There can be multiple ResourceBundle instances with
 *  different bundle names.</p>
 *  
 *  @see mx.resources.IResourceBundle
 *  @see mx.resources.IResourceManager
 *  
 *  @langversion 3.0
 *  @playerversion Flash 9
 *  @playerversion AIR 1.1
 *  @productversion Flex 3
 */
public class ResourceBundle implements IResourceBundle
{
    include "../core/Version.as";

    //--------------------------------------------------------------------------
    //
    //  Class variables
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     *  Set by SystemManager constructor in order to make the deprecated
     *  getResourceBundle() method work with the new resource scheme
     *  in the single-locale case.
     */
    mx_internal static var locale:String;

    /**
     *  @private
     *  Set by bootstrap loaders
     *  to allow for alternate search paths for resources
     */
    mx_internal static var backupApplicationDomain:ApplicationDomain;

    //--------------------------------------------------------------------------
    //
    //  Class methods
    //
    //--------------------------------------------------------------------------

    /**
     *  @private
     */
    private static function getClassByName(name:String,
                                           domain:ApplicationDomain):Class
    {
        var c:Class;

        if (domain.hasDefinition(name))
            c = domain.getDefinition(name) as Class;

        return c;
    }

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     *
     *  @param locale A locale string, such as <code>"en_US"</code>.
     *
     *  @param bundleName A name that identifies this bundle,
     *  such as <code>"MyResources"</code>.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    public function ResourceBundle(locale:String = null,
                                   bundleName:String = null)
    {
        // The only reason that the arguments are optional is so that
        // Flex 3 applications can link against Flex 2 resource SWCs.
        // In Flex 2, the constructor had no arguments at all
        // and the autogenerated ResourceBundle subclasses
        // therefore called super() with no arguments.
        // If, in Flex 3, the constructor has required arguments,
        // this causes a VerifyError.
        
        super();
        
        _locale = locale;
        _bundleName = bundleName;

        _content = getContent();
    }  

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  bundleName
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the bundleName property.
     */
    mx_internal var _bundleName:String;

    /**
     *  @copy mx.resources.IResourceBundle#bundleName
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */     
    public function get bundleName():String
    {
        return _bundleName;
    }

    //----------------------------------
    //  content
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the content property.
     */
    private var _content:Object = {};

    /**
     *  @copy mx.resources.IResourceBundle#content
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */     
    public function get content():Object
    {
        return _content;
    }

    //----------------------------------
    //  locale
    //----------------------------------
    
    /**
     *  @private
     *  Storage for the locale property.
     */
    mx_internal var _locale:String;

    /**
     *  @copy mx.resources.IResourceBundle#locale
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */     
    public function get locale():String
    {
        return _locale;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  When a properties file is compiled into a resource bundle,
     *  the MXML compiler autogenerates a subclass of ResourceBundle.
     *  The subclass overrides this method to return an Object
     *  that contains key-value pairs for the bundle's resources.
     *
     *  <p>If you create your own ResourceBundle instances,
     *  you can set the key-value pairs on the <code>content</code> object.</p>
     *  
     *  @return The Object that contains key-value pairs for the bundle's resources.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 9
     *  @playerversion AIR 1.1
     *  @productversion Flex 3
     */
    protected function getContent():Object
    {
        return {};
    }

    /**
     *  @private
     */
    private function _getObject(key:String):Object
    {
        var value:Object = content[key];
        if (!value)
        {
            throw new Error("Key " + key +
                            " was not found in resource bundle " + bundleName);
        }
        return value;
    }
}

}
