package com.dor.iso {
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.events.Event;

    //The view port for displaying and rendering;

    public class IsoView extends Sprite {
        public function IsoView() {
            init();
        }

        private var container : Sprite = new Sprite;

        public function init() : void {
            addChild(container);

            this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        }

        protected function onMouseDown(evt : MouseEvent) : void {
            
        }

        protected function onMouseUp(evt : MouseEvent) : void {

        }

        protected function onMouseMove(evt : MouseEvent) : void {

        }

        protected var children : Vector.<IsoLayer> = new Vector.<IsoLayer>();
        protected var length : uint = 0;

        public function addLayer(layer : IsoLayer) : IsoLayer {
            return addLayerAt(layer, children.length);
        }

        public function addLayerAt(layer : IsoLayer, index : int) : IsoLayer {
            var res : IsoLayer =  container.addChildAt(layer, index) as IsoLayer;

            if(res)
                children.splice(index, 0, res);
            else
                throw new Error("Error: IsoLayer Object doesn't exist.");

            length = children.length;
            return res;

        }

        public function removeLayer(layer : IsoLayer) : IsoLayer {
            return removeLayerAt(container.getChildIndex(layer));
        }

        public function removeLayerAt(index : int) : IsoLayer {
            var res : IsoLayer = container.removeChildAt(index) as IsoLayer;

            if(res)
                children.splice(index, 1);
            else
                throw new Error("Error: IsoLayer Object doesn't exist.");

            length = children.length;
            return res;
        }

        public function setLayerIndex(layer : IsoLayer, index : int) : void {
            var i : int = children.indexOf(layer);
            if(i == index) return;

            container.setChildIndex(layer, index);

            if( i > -1){
                children.splice(i, 1);
                children.splice(index, 0, layer);
            }
        }

        public var isRendering : Boolean = false;

        public function start() : void {
            isRendering = true;
            this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        public function stop() : void {
            isRendering = false;
        }

        public function onEnterFrame(evt : Event) : void {
           for(var i : int = 0; i < length; i++) {
               var layer : IsoLayer = children[i] as IsoLayer;
               layer.render();
           }
        }
    }
}
