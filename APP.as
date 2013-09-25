package  
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import com.mission.style.CQStyle;
	import com.mission.style.StyleAreaBase;
	
	/**
	 * ...
	 * @author lu
	 */
	public class APP extends Sprite 
	{
		private static const XML_PATH:String = "app:/xml/站厅/style.xml";
		private var _style_rc:Sprite;
		
		public function APP() 
		{
			_style_rc = new Sprite();
			_style_rc.x = _style_rc.y = 0;
			addChild(_style_rc);
			
			loadStyleXML();
			
			loadBG();
		}
		
		private function loadStyleXML():void {
			var doStyleLoadError:Function = function(e:IOErrorEvent):void {
				trace("load style xml error!");
			}
			var _request:URLRequest = new URLRequest(XML_PATH);
			
			var _url_loader:URLLoader = new URLLoader();
			_url_loader.addEventListener(Event.COMPLETE, doStyleLoaded);
			_url_loader.addEventListener(IOErrorEvent.IO_ERROR, doStyleLoadError);
			
			try{
			  _url_loader.load(_request);
			}catch (e:Error) {
				trace("load style xml error!");
			}
		}
		
		private function doStyleLoaded(e:Event):void {
			var _url_loader:URLLoader = URLLoader(e.target);
			var _style:XML = new XML(_url_loader.data);
			if (_style) {
				
				var _cq_style:CQStyle = new CQStyle(_style);
				var _style_area_list:Vector.<StyleAreaBase> = _cq_style.getStyleArea();
				var _len:int = _style_area_list.length;
				
				for (var i:int = 0; i < _len; i++ ) {
					var _style_area:StyleAreaBase = _style_area_list[i];
					_style_rc.addChild(_style_area);
				}
			}

		}
		
		
		private function loadBG():void {
			var request:URLRequest = new URLRequest("app:/xml/站厅/03aa48ea-f871-444a-8be8-9ca10f445ee8.jpg");
			var loader:Loader = new Loader();
			
			_style_rc.addChild(loader);
			try{
			loader.load(request);
			}catch (e:Error) {
				var _msg:String = e.message;
				trace(_msg);
			}
		}
		
	}

}