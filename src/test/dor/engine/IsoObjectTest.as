package test.dor.engine{
    import com.dor.engine.*;

    public class IsoSpriteTest {
        private var obj : IsoSprite;
        private var layer : IsoLayer;

        public function IsoObjectTest() : void {
            layer = new IsoLayer();
            obj = new IsoSprite();        

            layer.addChild(obj);
        }
    }
}
