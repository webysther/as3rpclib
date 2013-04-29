/**
 *
 * @package		com.ak33m.rpc.jsonrpc
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.jsonrpc
{
	import com.adobe.serialization.json.JSON;

	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 * @author	Webysther Nunes <webysther@gmail.com>
	 */
	public class JSONRPCSerializer
	{
		/**
		 * 
		 * @param	String	method
		 * @param	Array	params
		 * 
		 * @return	String
		 */
		public static function serialize( method : String , params : Array ) : String
		{
			return com.adobe.serialization.json.JSON.encode( { method:method , params:params , id:Math.random() * 1000 } );
		}
		
		/**
		 * 
		 * @param	String	result
		 * 
		 * @return	mixed
		 */
		public static function deserialize( result : String ) : *
		{
			return com.adobe.serialization.json.JSON.decode( result );
		}
	}
}