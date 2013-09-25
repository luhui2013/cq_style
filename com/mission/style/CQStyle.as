package com.mission.style 
{

	/**
	 * ...
	 * @author lu
	 */
	public class CQStyle 
	{
		private static var cur_i18n:String = "zh";
		private  static var en_list:Array=[];
		private static  var zh_list:Array=[];
		
		private var _style_area_list:Vector.<StyleAreaBase>;
		private var _xml:XML;
		private var _style_id:String;
		

		public function CQStyle(style_xml:XML)
		{
			_style_area_list = new Vector.<StyleAreaBase>();
			_xml = style_xml;
			
			_style_id = _xml.@id;
			parseXML();
		}
		
		private function parseXML():void {
			var _en:XMLList = _xml.i18n.en.children();
			var _zh:XMLList = _xml.i18n.zh.children();
			
			var _node:XML;
            CQStyle.en_list = [];
			for each(_node in _en) {
				CQStyle.en_list.push({"id":_node.@id,"val":_node.text()});
			}
			
			CQStyle.zh_list = [];
			for each(_node in _zh) {
				CQStyle.zh_list.push({"id":_node.@id,"val":_node.text()});
			}
			
			var _screen:XML = _xml.screen[0];
			var _style_area:XMLList = _screen.children.children();

			for each(_node in _style_area) {
				var _area:StyleAreaBase = StyleAreaBuilder.createStyleArea(_node);
				if(_area!=null){
				   _style_area_list.push(_area);
				}
			}
		}
		
		
		public function getStyleArea():Vector.<StyleAreaBase> {
			return _style_area_list;
		}
		
		public static function getResourceStr(id:String):String {
			var _resource_list:Array;
			if (cur_i18n == "zh") {
				_resource_list = zh_list;
			}else {
				_resource_list = en_list;
			}
			
			for each(var r:Object in _resource_list) {
				var _id:String = r["id"];
				if (_id == id) return r["val"];
			}
			
			return "";
		}
		
	}

}