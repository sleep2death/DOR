package com.dor.engine {
	import flash.events.Event;

	public class IsoEvent extends Event
	{
		static public const INVALIDATE:String = "sliso_invalidate";

		static public const RENDER:String = "sliso_render";

		static public const RENDER_COMPLETE:String = "sliso_render_complete";

		static public const MOVE:String = "sliso_move";

		static public const RESIZE:String = "sliso_resize";

		static public const CHILD_ADDED:String = "sliso_child_added";
		
		static public const CHILD_REMOVED:String = "sliso_child_removed";

		public var propName : String;
		
		public var oldValue : Object;
		
		public var newValue : Object;
		
		public function IsoEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone ():Event
		{
			var evt:IsoEvent = new IsoEvent(type, bubbles, cancelable);
			evt.propName = propName;
			evt.oldValue = oldValue;
			evt.newValue = newValue;
			
			return evt;
		}
	}
}
