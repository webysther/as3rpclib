/**
 *
 * @package		com.ak33m.rpc.amf0
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.amf0
{
	import flash.net.NetConnection;
	import flash.net.ObjectEncoding;
	import com.ak33m.rpc.core.IRPCConnection;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	public class AMF0Connection extends NetConnection implements IRPCConnection
	{
		/**
		 * 
		 * @param	String	url
		 * 
		 * @return	void
		 */
		public function AMF0Connection ( url : String ) : void
        {
            objectEncoding = ObjectEncoding.AMF0;
            if ( url ) {
            	connect( url );
			}
        }
	}
}