package com.dor.engine {
    import flash.events.IEventDispatcher;

    public class IsoObject {

        public var x : Number = 0;

        public var y : Number = 0;

        public var z : Number = 0;

        public function setX(value : Number) : void {
            x = value;
            pos_validated = false;
        }

        public function setY(value : Number) : void {
            y = value;
            pos_validated = false;
        }

        public function setZ(value : Number) : void {
            z = value;
            pos_validated = false;
        }

        public var width : Number = 0;

        public var length : Number = 0;

        public var height : Number = 0;

        public function setWidth(value : Number) : void {
            width = value;
           size_validated = false;
        }

        public function setLength(value : Number) : void {
            length = value;
            size_validated = false;
        }

        public function setHeight(value : Number) : void {
            height = value;
            size_validated = false;
        }

        protected var pos_validated : Boolean = false;

        protected var img_validated : Boolean = false;

        protected var size_validated : Boolean = false;

        public function get validated() : Boolean {
            return pos_validated && img_validated;
        }

        public var mouseEnabled : Boolean = false;

        public function IsoObject() : void {
        }

        public function render() : void {

        }

        public function get renderData() : RenderData {
            return null;
        }
    }
}
