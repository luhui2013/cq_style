package com.mission.style 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author lu
	 */
	public class StyleAreaBase extends Sprite 
	{
		protected var _id:String;
		protected var _x:int;
		protected var _y:int;
		protected var _width:int;
		protected var _height:int;
		protected var _alpha:int;
		
		
		public function StyleAreaBase() 
		{
			
		}
		
		public function parseXML(xml:XML):void {
			_id = xml.@id;
			_x = xml.@x;
			_y = xml.@y;
			_width = xml.@width;
			_height = xml.@height;
			_alpha = xml.@alpha;
			
			
			
		}
		
		
		public function get style_id():String {
			return _id;
		}
		public function get style_x():int {
			return _x;
		}
		public function get style_y():int {
			return _y;
		}
		public function get style_width():int {
			return _width;
		}
		public function get style_height():int {
			return _height;
		}
		public function get style_alpha():int {
			return _alpha;
		}
		
		override public function toString():String {
			return "_id:" + _id + " _x:" + _x + " _y:" + _y + " _width:" + _width + " _height:" + _height + " _alpha:" + _alpha;
			
		}
	
	}

}