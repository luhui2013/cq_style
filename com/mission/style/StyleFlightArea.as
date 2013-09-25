package com.mission.style 
{
	import flash.display.Graphics;
	import flash.events.IOErrorEvent;
	import flash.geom.Rectangle;
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import flash.net.URLRequest;
	
	import flash.html.HTMLLoader;
	/**
	 * ...
	 * @author lu
	 */
	public class StyleFlightArea extends StyleAreaBase 
	{
		
		public function StyleFlightArea() 
		{
			
		}
		
		override public function parseXML(xml:XML):void {
			super.parseXML(xml);
			
			updateView();
		}
		
		
		private function updateView():void {
			this.x = _x;
			this.y = _y;
			
			var urlReq:URLRequest = new URLRequest("app:/img/KG.html");
			var html:HTMLLoader = new HTMLLoader(); 
			html.paintsDefaultBackground = false;
			html.x = html.y = 0;
			html.width = _width;
			html.height = _height;
			html.addEventListener(Event.COMPLETE, doHtmlLoaded);
			
			html.load(urlReq); 
			
			addChild(html); 
			

			
		}
		private function doHtmlLoaded(e:Event):void {
			var _html:HTMLLoader = HTMLLoader(e.target);
			
			
			var _doLoaded:Function = function(e:Event):void {
				var _xml_loader:URLLoader = URLLoader(e.target);
				var _xml:String = _xml_loader.data as String;
				
				_html.window.loadData(_xml);
			};
			var _request:URLRequest = new URLRequest("app:/img/flightInfo.xml");
			
			var _loader:URLLoader = new URLLoader();
			_loader.addEventListener(Event.COMPLETE, _doLoaded);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, function(e:IOErrorEvent):void {
				trace("load flightInfo.xml failed!");
			});
			
			try {
				_loader.load(_request);
			}catch (e:Error) {
				trace("load flightInfo.xml failed!");
			}
			
		}
	}

}