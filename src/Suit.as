package {
    import flash.display.Sprite;
    import test.dor.iso.IsoSpriteFromExternalTest;

    public class Suit extends Sprite {

        public function Suit() : void{
            var external_sprite_test : IsoSpriteFromExternalTest = new IsoSpriteFromExternalTest();
            addChild(external_sprite_test);
        }

    }
}
