package com.mission.style 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author lu
	 */
	public class StyleAtsArea extends StyleAreaBase 
	{
		private var _week_list:Array = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
		private var _skin_id:String;
		private var _name:String;
		
		public function StyleAtsArea() 
		{
			
		}
		
		override public function parseXML(xml:XML):void {
			super.parseXML(xml);
			
			_skin_id = xml.skin.@id;
			if (_skin_id) {
				loadSkin();
			}
			
			updateView();
		}
		
		private function updateView():void {
			this.x = _x;
			this.y = _y;
			
		}
		
		private function loadSkin():void {
			var _request:URLRequest = new URLRequest("app:/xml/站厅/"+_skin_id+".xml");
			var _url_loader:URLLoader = new URLLoader();
			_url_loader.addEventListener(Event.COMPLETE, doSkinLoaded);
			_url_loader.addEventListener(IOErrorEvent.IO_ERROR, doSkinLoadError);
			
			try {
				_url_loader.load(_request);
			}catch (e:Error) {
				trace("load ats skin "+_skin_id+" failed!");
			}
		}
		private function doSkinLoaded(e:Event):void {
			var _load:URLLoader = URLLoader(e.target);
			var _skin:XML = new XML(_load.data);
			
			_name = _skin.property.@name;
			var _static_txt_list:XMLList = _skin.static_txt;
			for each(var _txt:XML in _static_txt_list) {
				var _st:StaticText = StaticText.parseXML(_txt);
				trace(_st);
				
				createStaticText(_st);
			}
			
			var _dynamic_txt_list:XMLList = _skin.dynamic_txt;
			for each(_txt in _dynamic_txt_list) {
				var _dt:DynamicText = DynamicText.parseXML(_txt);
				createDynamicText(_dt);
			}
		}
		private function createStaticText(t:StaticText):void {
			var tf:TextFormat = new TextFormat();
			tf.font = t.font;
			tf.size = t.font_size;
			tf.color = t.font_color;
			tf.align = TextFormatAlign.LEFT;
			
			var _txt:TextField = new TextField();
			_txt.autoSize=TextFormatAlign.LEFT;
			_txt.selectable = false;
			_txt.x = t.x;
			_txt.y = t.y;
			_txt.defaultTextFormat = tf;
			
			var _t_str:String = t.text.replace("{", "").replace("}", "");
			_txt.text = CQStyle.getResourceStr(_t_str);
			addChild(_txt);
		}
		private function createDynamicText(t:DynamicText):void {
			var _fullt:Function = function(val:int):String
			{
				var result:String;
				if (val <= 9)
				{
					result = "0" + val;
				}else {
					result = val.toString();
				}
				return result;
			}
			
			var tf:TextFormat = new TextFormat();
			tf.font = t.font;
			tf.size = t.font_size;
			tf.color = t.font_color;
			tf.align = TextFormatAlign.LEFT;
			
			var _txt:TextField = new TextField();
			_txt.selectable = false;
			_txt.x = t.x;
			_txt.y = t.y;
			_txt.autoSize=TextFormatAlign.LEFT;
			_txt.defaultTextFormat = tf;
			
			var _dt:Date;
			switch(t.name) {
				case "cur_station_name":
					_txt.text = "江北机场站";
					break;
				case "date":
					_dt = new Date();
					_txt.text = _dt.fullYear+"年"+(_dt.getMonth()+1)+"月"+_dt.date+"日";
					break;
				case "week":
					_dt = new Date();
					_txt.text = _week_list[_dt.day];
					break;
				case "time":
					_dt = new Date();
					_txt.text = _fullt(_dt.hours)+":"+_fullt(_dt.minutes)+":"+_fullt(_dt.seconds);
					break;
				case "to_station1":
					_txt.text = "二滩";
					break;
				case "first_train1":
					_txt.text = "6:00";
					break;
				case "last_train1":
					_txt.text = "22:00";
					break;
					case "to_station2":
					_txt.text = "江北机场";
					break;
				case "first_train2":
					_txt.text = "6:00";
					break;
				case "last_train2":
					_txt.text = "22:00";
					break;
				case "first_train_arrival":
					_txt.text = "1分钟";
					break;
				case "next_train_to":
					_txt.text = "江北机场";
					break;
				case "second_train_arrival":
					_txt.text = "05:20";
					break;
				
				default:break;	
			}
			
			addChild(_txt);
		}
		
		private function doSkinLoadError(e:IOErrorEvent):void {
			trace("load ats skin "+_skin_id+" failed!");
		}
		
	}

}



class StaticText {
	public var id:String;
	public var x:int;
	public var y:int;
	public var width:int;
	public var height:int;
	
	public var font:String;
	public var font_size:int;
	public var font_color:String;
	public var text:String;
	
	
	public static function parseXML(xml:XML):StaticText {
		var _txt:StaticText = new StaticText();
		_txt.id = xml.@id;
		_txt.x = xml.@x;
		_txt.y = xml.@y;
		_txt.width = xml.@width;
		_txt.height = xml.@height;
		
		var _f:XML = xml.font[0];
		_txt.font = _f.@font_family;
		_txt.font_size = _f.@font_size;
		_txt.font_color = _f.@font_color;
		
		_txt.text = xml.property.@text;
		return _txt;
	}
	
   public function toString():String {
		var _s:String = "id:" + id;
		_s += " x:" + x;
		_s += " y:" + y;
		_s += " width:" + width;
		_s += " height:" + height;
		_s += " font:" + font;
		_s += " font_size:" + font_size;
		_s += " font_color:" + font_color;
		_s += " text:" + text;
		
		return _s;
	}
}

class DynamicText {
	public var id:String;
	public var name:String;
	public var x:int;
	public var y:int;
	public var width:int;
	public var height:int;
	
	public var font:String;
	public var font_size:int;
	public var font_color:String;
	public var text:String;
	
	
	public static function parseXML(xml:XML):DynamicText {
		var _txt:DynamicText = new DynamicText();
		_txt.id = xml.@id;
		_txt.x = xml.@x;
		_txt.y = xml.@y;
		_txt.width = xml.@width;
		_txt.height = xml.@height;
		
		var _f:XML = xml.font[0];
		_txt.font = _f.@font_family;
		_txt.font_size = _f.@font_size;
		_txt.font_color = _f.@font_color;
		
		_txt.name = xml.property.@name;
		_txt.text = xml.property.@text;
		return _txt;
	}
}


