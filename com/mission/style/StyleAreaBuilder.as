package  com.mission.style 
{
	import com.mission.style.StyleAreaBase;
	/**
	 * ...
	 * @author lu
	 */
	public class StyleAreaBuilder 
	{
		public static const STYLE_AREA_TYLE_VIDEO:String = "video";
		public static const STYLE_AREA_TYLE_SCROLL_TXT:String = "scroll_txt";
		public static const STYLE_AREA_TYLE_ATS:String = "ats";
		public static const STYLE_AREA_TYLE_FLIGHT:String = "flight";
		
		
		public static function createStyleArea(style_area:XML):StyleAreaBase {
			var _result:StyleAreaBase = null;
			var _node_name:String = style_area.name();
			_node_name = _node_name.toLowerCase();
			
			switch(_node_name) {
					case StyleAreaBuilder.STYLE_AREA_TYLE_VIDEO:
						_result = new StyleVideoArea();
						_result.parseXML(style_area);
						break;
					case StyleAreaBuilder.STYLE_AREA_TYLE_SCROLL_TXT:
						_result = new StyleScrollTxtArea();
						_result.parseXML(style_area);
						break;
					case StyleAreaBuilder.STYLE_AREA_TYLE_ATS:
						_result = new StyleAtsArea();
						_result.parseXML(style_area);
						break;
					case StyleAreaBuilder.STYLE_AREA_TYLE_FLIGHT:
						_result = new StyleFlightArea();
						_result.parseXML(style_area);
						
						break;
						default: break;
				}
			
			return _result;
		}
		
		public function StyleAreaBuilder() 
		{
			
		}
		
	}

}