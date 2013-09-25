package com.mission.style 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * ...
	 * @author lu
	 */
	public class StyleScrollTxtArea extends StyleAreaBase 
	{
		private var _name:String;
		private var _scroll_type:String;
		
		private var _font:String;
		private var _font_size:int;
		private var _font_color:String;
		
		private var _txt:TextField;
		
		
		public function StyleScrollTxtArea() 
		{
			
		}
		
		override public function parseXML(xml:XML):void {
			super.parseXML(xml);
			
			var _val:String = null;
			_val = xml.property.@name;
			if (_val) {
				_name = _val;
				_val = null;
			}
			
			_val = xml.property.@scroll_type;
			if (_val) {
				_scroll_type = _val;
				_val = null;
			}
			
			var _style_font:XML = xml.font[0];
			_font = _style_font.@font_family;
			_font_size = _style_font.@font_size;
			_font_color = _style_font.@font_color;
			
			updateView();
		}
		
		private function updateView():void {
			this.x = this._x;
			this.y = this._y;
			
			if (_txt == null) {
				_txt = new TextField();
				_txt.selectable = false;
				_txt.autoSize=TextFormatAlign.LEFT;
			    _txt.x = _txt.y = 0;
			    addChild(_txt);
			}
			var tf:TextFormat = new TextFormat();
			tf.font = _font;
			tf.size = _font_size;
			tf.color = _font_color;
			tf.align = TextFormatAlign.LEFT;
			
			_txt.defaultTextFormat = tf;
			_txt.text = "重庆地铁欢迎你！";
		}
		
	}

}