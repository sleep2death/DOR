package com.dor.engine {
    import flash.display.Sprite;
    import flash.events.EventDispatcher;

    public class IsoLayer extends EventDispatcher{

        public function IsoLayer(container : Sprite = null) : void {
            setContainer(container);
        }
        //

        public var container : Sprite;

        public function setContainer(container : Sprite) : void {
            if(this.container){
                while(this.container.numChildren > 0) {
                    container.addChild(this.container.removeChildAt(0));
                }
            }

            this.container = container;
        }

        protected var children : Array = new Array();

		public function addChild(child : IsoSprite, broadcast : Boolean = false) : void {
			addChildAt(child, numChildren, broadcast);
		}

		public function addChildAt(child : IsoSprite, index : uint, broadcast : Boolean = false) : void {
			if (child.parent) {
				var parent : IsoLayer = child.parent;
				parent.removeChildByID(child.id);
			}
			
			IsoSprite(child).parent = this;
			children.splice(index, 0, child);
			
            if(broadcast){
                var evt : IsoEvent = new IsoEvent(IsoEvent.CHILD_ADDED);
                evt.newValue = child;
                
                dispatchEvent(evt);
            }
		}

		public function getChildByID(id : String) : IsoSprite {
			var childID : String;
			var child : IsoSprite;
			for each (child in children) {
				childID = child.id;
				if (childID == id)
					return child;
			}
			
			return null;
		}

		public function getChildAt(index : uint) : IsoSprite {
			if (index >= numChildren)
				throw new Error("The index is out of range.");
			
			else
				return IsoSprite(children[index]);
		}

		public function getChildIndex(child : IsoSprite) : int {
			var i : int;
			while (i < numChildren) {
				if (child == children[i])
					return i;
				
				i++;
			}
			
			return -1;
		}
		
		public function setChildIndex (child:IsoSprite, index:uint):void
		{
			var i:int = getChildIndex(child);
			if (i == index)
				return;
				
			if (i > -1)
			{
				children.splice(i, 1);
				
				var c:IsoSprite;
				var notRemoved:Boolean = false;
				for each (c in children)
				{
					if (c == child)
						notRemoved = true;
				}
				
				if (notRemoved)
				{
					throw new Error("");
					return;
				}
				
				if (index >= numChildren)
					children.push(child);
				
				else
					children.splice(index, 0, child);
			}
			
			else
				throw new Error("Child is NOT in the layer.");
		}

		public function contains(child : IsoSprite) : Boolean {
			if (child.hasParent)
				return child.parent == this; 

            var theChild : IsoSprite;

            for each (theChild in children) {
                if (theChild == child)
                    return true;
            }
            
            return false;
		}

		public function removeChild(child : IsoSprite) : IsoSprite {
			return removeChildByID(child.id);
		}
		
		public function removeChildAt(index : uint) : IsoSprite {				
			var child : IsoSprite;
			if (index >= numChildren)
				return null;
				
			else
				child = IsoSprite(children[index]);
				
			return removeChildByID(child.id);
		}

		public function removeChildByID(id : String, broadcast : Boolean = false) : IsoSprite {
			var child : IsoSprite = getChildByID(id);
			if (child) {
				IsoSprite(child).parent = null;
				
				var i : uint;
				for (i;i < children.length;i++) {
					if (child == children[i]) {
						children.splice(i, 1);
						break;
					}
				}
				
                if(broadcast){
                    var evt : IsoEvent = new IsoEvent(IsoEvent.CHILD_REMOVED);
                    evt.newValue = child;
                    
                    dispatchEvent(evt);
                }
			}
			
			return child;
		}

		public function removeAllChildren() : void {
			var child : IsoSprite;
			for each (child in children) {
				IsoSprite(child).parent = null;
			}

			children = new Array();
		}

		public function get numChildren() : uint {
			return children.length;
		}
    }
}
