package com.dor.iso {
    import flash.utils.ByteArray;

    public class TileGrid {
        public function TileGrid() : void {
        }

        private var map_data : ByteArray = new ByteArray();

        protected var col : uint;
        protected var row : uint;

        public function init_map(col : uint, row : uint) : void {
            this.col = col;
            this.row = row;

            for(var i : uint = 0; i < col; i++){
                for(var j : uint = 0; j < row; j++) {
                    //'0' means the tile has not been written yet.
                    map_data.writeByte(0);
                }
            }
        }

        public function read_tile(x : uint, y : uint) : int {
            var offset : uint = y * col + x; 
            map_data.position = offset;

            return map_data.readByte();
        }

        public function write_tile(x : uint, y : uint, value : int) : void {
            var offset : uint = y * col + x; 
            map_data.position = offset;

            return map_data.writeByte(value);
        }

    }
}
