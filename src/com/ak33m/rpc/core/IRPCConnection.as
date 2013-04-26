/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.core
{
	import flash.net.Responder;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	public interface IRPCConnection
	{
		/**
		 * Invoke RPC call to server
		 */
		function call(command:String,responder:Responder,...arguments):void;
	}
}