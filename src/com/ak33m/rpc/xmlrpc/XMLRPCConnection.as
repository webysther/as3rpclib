/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.xmlrpc
{
	import com.ak33m.rpc.core.IRPCConnection;
	import flash.net.Responder;
	import mx.rpc.http.HTTPService;
	import flash.net.URLRequestHeader;

	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	public class XMLRPCConnection extends HTTPService  implements IRPCConnection
	{	
		/**
		 * 
		 * @param rootURL
		 * 
		 */		
		public function XMLRPCConnection (rootURL:String=null)
		{
			super(rootURL);
			this.method = "post";
		}
		
		/**
		 * 
		 * @param command
		 * @param responder
		 * @param args
		 * 
		 */		
		public function call(command:String,responder:Responder,...args):void
		{
			var trequestxml:XML = XMLRPCSerializer.serialize(command,args);
			send(trequestxml);
		}
	}
}