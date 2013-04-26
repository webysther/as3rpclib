/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.jsonrpc
{
	import com.ak33m.rpc.core.IRPCConnection;
	import flash.net.Responder;
	import mx.rpc.http.HTTPService;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	public class JSONConnection extends HTTPService implements IRPCConnection
	{
		
		/**
		 * 
		 * @param rootURL
		 * 
		 */		
		public function JSONConnection(rootURL:String=null)
		{
			super(rootURL);
		}
		
		/**
		 * 
		 * @param command
		 * @param responder
		 * @param arguments
		 * 
		 */		
		public function call(command:String, responder:Responder, ...arguments):void
		{
			var request:String = JSONRPCSerializer.serialize(command,arguments);
			send(request);
		}
		
	}
}