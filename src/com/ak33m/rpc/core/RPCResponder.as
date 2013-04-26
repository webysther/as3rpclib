/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.core
{
	import mx.rpc.IResponder;
	import flash.net.Responder;
	import mx.rpc.AsyncToken;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.Fault;
	import flash.events.*;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	public class RPCResponder extends Responder implements IEventDispatcher,IResponder
	{
		/**
		 * 
		 */		
		protected var _token:AsyncToken;
		
		/**
		 * 
		 */		
		protected var _timeout:Number = 0;
		
		/**
		 * 
		 */		
		protected var _timer:Timer;
		
		/**
		 * 
		 */		
		protected var _dispatcher:EventDispatcher;
		
		
		/**
		 * 
		 * @param token
		 * 
		 */		
		public function RPCResponder (token:AsyncToken)
		{
			super(this.result,this.fault);
			this._dispatcher = new EventDispatcher(this);
			this._token = token;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get token ():AsyncToken
		{
			return this._token;
		}
		
		/**
		 * 
		 * @param value
		 * 
		 */		
		public function set timeout (value:Number) : void
        {
            _timeout = value;
            _timer = new Timer(value,1);
            if (_timeout > 0)
            {
                _timer.addEventListener(TimerEvent.TIMER_COMPLETE,cancelRequest);
                _timer.start();
            }
        }
        
		/**
		 * 
		 * @return 
		 * 
		 */		
        public function get timeout (): Number
        {
            return _timeout;
        }
		
		/**
		 * 
		 * @param data
		 * 
		 */		
		public function result (data:Object):void
		{
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,cancelRequest);
			dispatchEvent(new RPCEvent(RPCEvent.EVENT_RESULT,false,true,data));
		}
		
		/**
		 * 
		 * @param info
		 * 
		 */		
		public function fault (info:Object):void
		{
			this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,cancelRequest);
			dispatchEvent(new RPCEvent(RPCEvent.EVENT_FAULT,false,true,info));
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function cancelRequest (event:TimerEvent):void
		{
			if (event.target.currentCount == 1)
			{
				dispatchEvent(new RPCEvent(RPCEvent.EVENT_CANCEL,false,true));
			}
		}
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 * 
		 */		
		//EVENTDISPATCHER IMPLEMENTATION
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
       	 	this._dispatcher.addEventListener(type, listener, useCapture, priority);
   		}
          
		/**
		 * 
		 * @param evt
		 * @return 
		 * 
		 */		
	    public function dispatchEvent(evt:Event):Boolean
	    {
	        return this._dispatcher.dispatchEvent(evt);
	    }
		
		/**
		 * 
		 * @param type
		 * @return 
		 * 
		 */    	
	    public function hasEventListener(type:String):Boolean
	    {
	        return this._dispatcher.hasEventListener(type);
	    }
    
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * 
		 */		
	    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void
	    {
	        this._dispatcher.removeEventListener(type, listener, useCapture);
	    }
          
		/**
		 * 
		 * @param type
		 * @return 
		 * 
		 */		
	    public function willTrigger(type:String):Boolean 
	    {
	        return this._dispatcher.willTrigger(type);
	    }
	}
}