package com.ak33m.rpc.xmlrpc {
	
	import com.ak33m.rpc.xmlrpc.IXMLRPCStruct;
	
	public class XMLRPCStruct extends Array implements IXMLRPCStruct 
	{
		private var props:Array = new Array() ;
		public function XMLRPCStruct( key:String = null , value:* = null ) : void
		{
			super(); 
			if ( key != null && value != null ) {
				this.add( key , value );
			}
		}
		
		public function add( key:String , value:* ):void 
		{
			props[key] = value;
		}
		
		public function getPropertyData():* 
		{
			return props;
		}
	}
}