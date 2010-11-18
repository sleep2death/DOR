package {
    import flash.display.Sprite;
    import test.dor.iso.IsoViewTest;
    import com.flashdynamix.utils.SWFProfiler;

    public class Suit extends Sprite {

        public function Suit() : void{
            //var external_sprite_test : IsoSpriteFromExternalTest = new IsoSpriteFromExternalTest();
            //addChild(external_sprite_test);

            var it : IsoViewTest = new IsoViewTest();
            addChild(it);
        }

    }
}
