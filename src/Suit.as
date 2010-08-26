package {
    import flash.display.Sprite;
    import test.dor.engine.IsoSpriteTest;

    public class Suit extends Sprite {

        public function Suit() : void{
            var test : IsoSpriteTest = new IsoSpriteTest();            
            addChild(test);
        }

    }
}
