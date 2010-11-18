package test.dor.iso {
    import com.dor.iso.IsoSpriteFromExternal;
    import com.dor.iso.IsoLayer;
    import flash.events.Event;

    public class IsoSpriteFromExternalTest extends IsoLayer{
        private var amount : int = 1200;
        
        public function IsoSpriteFromExternalTest(){
            for(var i : int = 0; i < amount; i++){
                var sp : IsoSpriteFromExternal = new IsoSpriteFromExternal();
                sp.url = 'http://00.static.slide.com/loa/pDPrC03O0qn_pGM71tIk1tya39FwAxm8TZ5Ok3_dTCTq19ZwS_YxpG9u2YMtQUnLA3Se8ISN-DOVPGt2K1EBZ0zV87KaYP7VpQEOH8YFmQZlDdjB8ihoXhw4kKf84rUZ5Nl4Es01K3ehj2syJOtSZA'

                sp.mc_name = "frontwalk";

                sp.validate_img();

                sp.set_pos(Math.random()*600, 0, Math.random()*600);

                sp.validate_pos();

                addChild(sp);
            }              

            this.x = 350;
            this.y = 0;

            this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(evt : Event) : void {
            for(var i : int = 0; i < amount; i++){
                var sp : IsoSpriteFromExternal = children[i] as IsoSpriteFromExternal;

                if(sp.current_frame < sp.total_frames)
                    sp.current_frame++;
                else
                    sp.current_frame = 0;

                sp.validate_img();
            }
        }
    }
}
