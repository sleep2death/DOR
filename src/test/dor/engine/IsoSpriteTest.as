package test.dor.engine{
    import com.dor.engine.*;
    import flash.display.Sprite;
    import nl.demonsters.debugger.MonsterDebugger;

    public class IsoSpriteTest extends Sprite{

        private var obj : IsoSprite;
        private var obj1 : IsoSprite;
        private var obj2 : IsoSprite;
        private var obj3 : IsoSprite;

        private var layer : IsoLayer;
        private var layer1 : IsoLayer;

        public function IsoSpriteTest() : void {
            layer = new IsoLayer(new Sprite());
            layer1 = new IsoLayer(new Sprite());

            addChild(layer.container);

            obj = new IsoSprite();        

            obj1 = new IsoSprite();        

            obj2 = new IsoSprite();        

            obj3 = new IsoSprite();        

            obj.view.graphics.beginFill(0x000000, 1);
            obj.view.graphics.drawRect(0, 0, 40, 40);
            obj.view.graphics.endFill();

            runTest();
        }
        
        public function runTest() : void {
            testAddChild();
        }

        public function testAddChild() : void {
            layer.addChild(obj);
            MonsterDebugger.trace("THE NUM_CHILDREN:", layer.numChildren == 1? "OK" : "WRONG");
                                                                                      
            layer.addChild(obj);                                                      
            MonsterDebugger.trace("THE NUM_CHILDREN:", layer.numChildren == 1? "OK" : "WRONG");
                                                                                      
            layer.addChild(obj1);                                                     
            MonsterDebugger.trace("THE NUM_CHILDREN:", layer.numChildren == 2? "OK" : "WRONG");

            layer.addChild(obj2);                                                     
            MonsterDebugger.trace("THE NUM_CHILDREN:", layer.numChildren == 3? "OK" : "WRONG");

            layer.addChild(obj3);                                                     
            MonsterDebugger.trace("THE NUM_CHILDREN:", layer.numChildren == 4? "OK" : "WRONG");

            layer.addChild(obj);                                                     
            MonsterDebugger.trace("THE NUM_CHILDREN:", layer.getChildAt(3) == obj? "OK" : "WRONG");
        }

        
    }
}
