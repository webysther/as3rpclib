/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.jsonrpc
{
	import mx.rpc.AsyncToken;
	import com.ak33m.rpc.core.*;
	import mx.rpc.AsyncToken;
	import mx.managers.CursorManager;
	import mx.messaging.messages.IMessage;
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.events.*;
	import mx.rpc.Fault;
	import mx.messaging.messages.HTTPRequestMessage;
	import mx.core.IMXMLObject;
	import mx.rpc.mxml.IMXMLSupport;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	dynamic public class JSONRPCObject extends AbstractRPCObject
	{
		/**
		 * 
		 */		
		protected var _gateway:JSONConnection;
		
		/**
		 * 
		 * @param method
		 * @param args
		 * @return 
		 * 
		 */		
		override protected function makeCall(method:String, args:Array):AsyncToken
		{
			this._gateway.url = this.endpoint+this.destination;
			this._gateway.request = "POST";
			this._gateway.contentType = "application/xml";
			this._gateway.resultFormat = "object"; //Must be set to object in order for the xmlDecode to be used
			this._gateway.xmlDecode = JSONRPCSerializer.deserialize; //Converts results to AS3 objects
			this._gateway.requestTimeout = this.requestTimeout;
			var ttoken:AsyncToken = this._gateway.send(JSONRPCSerializer.serialize(method,args));
			
			//====== THIS IS A HACK IMPLEMENTED TO THROW FAULT EVENTS FROM THE XML RPC CALL
			//@TODO think of better solution to this problem
			var rpctoken:AsyncToken = new AsyncToken(ttoken.message);//create "fake" token with the real token message
			var responder:RPCResponder = new RPCResponder (rpctoken); //Create a responder
			responder.timeout = this.requestTimeout;
			responder.addEventListener(RPCEvent.EVENT_RESULT,this.onResult);
            responder.addEventListener(RPCEvent.EVENT_FAULT,this.onFault);
            responder.addEventListener(RPCEvent.EVENT_CANCEL,this.onRemoveResponder);
            ttoken.addResponder(responder);
            return rpctoken;
		}
		
		/**
		 * The root url of the xmlrpc path. 
		 * @example endpoint="http://localhost/"
		 */
		override public function set endpoint (endpoint:String):void
		{
			this._endpoint = endpoint;
			this.makeConnection();
		}
		
		/**
		 * 
		 * @param evt
		 * 
		 */		
		override protected function onResult (evt:RPCEvent):void
		{
			var token:AsyncToken = evt.target.token;
			var resultevent:ResultEvent = ResultEvent(evt.data); //@NOTE because the RPCResponder is a responder to HTTPService the result data will be a result event
			token.message.body = resultevent.result; //The actual data would be in the result
			if (resultevent.result.error!= null )//The XMLRPCSerializer.deserialize will return a fault object if a fault is returned by the rpc call
			{
				var tfault:Fault = new Fault("JSONRPC ERROR","AN ERROR MESSAGE WAS THROWN",resultevent.result.error);
				var faultevent:FaultEvent= new FaultEvent(FaultEvent.FAULT,true,true,tfault,token);
				dispatchEvent(faultevent);
				if (token.hasResponder())
				{
					for (var i:int; i<token.responders.length; i++)
					{
						token.responders[i].fault.call(token.responders[i],faultevent);
					}
				}
			}
			else
			{
				dispatchEvent(resultevent);
				if (token.hasResponder())
				{
					for (var j:int; j<token.responders.length; j++)
					{
						token.responders[j].result.call(token.responders[j],resultevent);
					}
				}
			}
		}
		
		/**
		 * 
		 * @param evt
		 * 
		 */		
		override protected function onFault (evt:RPCEvent):void
		{
			var token:AsyncToken = evt.target.token;
			var faultevent:FaultEvent= FaultEvent(evt.data);
			dispatchEvent(faultevent);
			if (token.hasResponder())
			{
				for (var i:int; i<token.responders.length; i++)
				{
					token.responders[i].fault.call(token.responders[i],faultevent);
				}
			}
		}
		
		 /**
		  * 
		  * 
		  */		
		 public function makeConnection ():void
        {
        	this._gateway = new JSONConnection(this._endpoint);
        }
	}
}