
package spark.globalization
{

import flash.globalization.CollatorMode;

import spark.globalization.supportClasses.CollatorBase;

/**
 *  The <code>MatchingCollator</code> class provides locale-sensitve string
 *  comparison capabilities with inital settings suitable for general string
 * matching such as finding a matching word in a block of text.
 *
 *  <p>This class is a wrapper class around the
 *  <code>flash.globalization.Collator</code>.
 *  Therefore the locale-specific string comparison is provided by the
 *  <code>flash.globalization.Collator</code>.
 *  However, this MatchingCollator class can be used in MXML declartions, uses
 *  the locale style for the requested Locale ID name, and has methods and
 *  properties that are bindable.
 *  Additionally, <code>LastOperationStatus</code>  is set, if there is an error or warning
 *  generated by the flash.globalization class.</p>
 *
 *  <p>The flash.globalization.Collator class uses the underlying operating
 *  system for the formatting functionality and to supply the locale
 *  specific data.
 *  On some operating systems, the flash.globalization classes are
 *  unsupported, this wrapper class provides a fallback functionality.</p>
 *
 *  @includeExample examples/MatchingCollatorExample.mxml
 *
 *  @see flash.globalization.Collator
 *
 *  @langversion 3.0
 *  @playerversion Flash 10.1
 *  @playerversion AIR 2.5
 *  @productversion Flex 4.5
 */
public class MatchingCollator extends CollatorBase
{
    include "../core/Version.as";

    //---------------------------------------------------------------------
    //
    //  Constructor
    //
    //---------------------------------------------------------------------

    /**
     *  Constructs a new MatchingCollator object to provide string
     *  comparisons according to the conventions of a specified locale.
     *
     *  <p>This class sets the initial values of the various collation
     *  for general string matching uses such as determining if two strings
     *  are equivalent or finding a matching word in a block of text.
     *  In this mode, differences in uppercase and lower case letters,
     *  accented characters, and so on are ignored when doing string
     *  comparisons.</p>
     *
     *  <p>The comparison provided by an instance of this class is
     *  equivalent to constructing an instance of the
     *  <code>flash.globalization.Collator</code> with the
     *  <code>initialMode</code> paramater set to
     *  <code>CollatorMode.MATCHING</code>.
     *  For more details and examples of this mode, please
     *  see the documentation for the
     *  <code>flash.globalization.Collator</code> class</p>
     *
     *  <p>The locale for this class is supplied by the locale style.
     *  The locale style can be set in several ways:</p>
     *
     *  <ul>
     *      <li>Inheriting the style from a <code>UIComponent</code> by calling the
     *          UIComponent's addStyleClient method.</li>
     *      <li>By using the class in an MXML declaration and inheriting the
     *          locale from the document that contains the declaration.
     *  <pre>
     *  Example:
     *  &lt;fx:Declarations&gt;
     *         &lt;s:MatchingCollator id="mc" /&gt;
     *  &lt;/fx:Declarations&gt;
     *  </pre>
     *  </li>
     *      <li>By using an MXML declaration and specifying the locale value
     *              in the list of assignments.
     *  <pre>
     *  Example:
     *  &lt;fx:Declarations&gt;
     *      &lt;s:MatchingCollator id="mc_France" locale="fr-FR" /&gt;
     *  &lt;/fx:Declarations&gt;
     *  </pre>
     *  </li>
     *      <li>Calling the setStyle method, e.g.
     *              <code>mc.setStyle("locale", "fr-FR")</code></li>
     *  </ul>
     *  <p>
     *  If the <code>locale</code> style is not set by one of the above 
     *  techniques, the instance of this class will be added as a 
     *  <code>StyleClient</code> to the <code>topLevelApplication</code> and 
     *  will therefore inherit the <code>locale</code> style from the 
     *  <code>topLevelApplication</code> object when the <code>locale</code> 
     *  dependent property getter or <code>locale</code> dependent method is 
     *  called.
     *  </p>   
     *
     *  @see flash.globalization.Collator
     *  @langversion 3.0
     *  @playerversion Flash 10.1
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */
    public function MatchingCollator()
    {
        super(CollatorMode.MATCHING);
    }
}
}
