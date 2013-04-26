/**
 *
 * @package		com.ak33m.rpc.amf0
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.amf0
{
	import com.ak33m.rpc.core.*;
	
	import mx.managers.CursorManager;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.*;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	dynamic public class AMF0Object extends AbstractRPCObject
	{
		/**
		 * @var	 AMF0Connection
		 */		
		protected var _gateway:AMF0Connection;
		
		/**
		 * 
		 * @param	String endpoint
		 * 
		 * @return	void
		 */		
		public function AMF0Object( endpoint : String = null ) : void
		{
			super();
			this.endpoint = endpoint;
		}
		
		/**
		 * 
		 * @param	String	endpoint
		 * 
		 * @return	void
		 */		
		override public function set endpoint( endpoint : String ) : void
		{
			this._endpoint = endpoint;
			this.makeConnection();
		}
		
		/**
		 * 
		 * @param	String	method
		 * @param	Array	args
		 * 
		 * @return	AsyncToken
		 */		
		override protected function makeCall( method : String , args : Array ) : AsyncToken
        {
        	var tmessage : RemotingMessage = new RemotingMessage();
        	tmessage.operation = method;
        	tmessage.destination = this.destination;
			
        	var ttoken:AsyncToken = new AsyncToken( tmessage );
            var responder:RPCResponder = new RPCResponder ( ttoken );
			
            responder.timeout = this.requestTimeout;
            responder.addEventListener( RPCEvent.EVENT_RESULT , this.onResult );
            responder.addEventListener( RPCEvent.EVENT_FAULT , this.onFault );
            responder.addEventListener( RPCEvent.EVENT_CANCEL , this.onRemoveResponder );
            _responders.addItem( responder );
			
            var params : Array = args;
            
            if ( args.length > 0 )
			{
                params.unshift( this._destination + "." + method , responder );
                this._gateway.call.apply( this._gateway , params );
            }
            else
            {
                this._gateway.call( this._destination + "." + method , responder );
            }
			 
            dispatchEvent( new InvokeEvent( "invoke" , false , true , ttoken , ttoken.message ) );
            
             //Show Busy cursor 
			this.respondercounter++;
            return ttoken;
        }
        
		/**
		 * 
		 * @return	void
		 */		
        public function makeConnection() : void
        {
        	this._gateway = new AMF0Connection( this._endpoint );
        }
		
	}
}