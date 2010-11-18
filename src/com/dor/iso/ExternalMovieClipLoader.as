package com.dor.iso{
        import flash.display.MovieClip;
        import flash.display.Loader;
        import flash.utils.Dictionary;
        import flash.geom.Rectangle;
        import com.dor.iso.RenderData;

        public class ExternalMovieClipLoader {

                private static var loader_pool : Dictionary = new Dictionary();

                public static function toString() : String
                {
                        var loader_count : int = 0;        
                        var mc_instance : int = 0;        

                        for(var url : String in loader_pool) {
                                var loader : EmbedLoader = loader_pool[url];
                                loader_count++;
                                        for (var mc_name : String in loader.mc_pool) {
                                                mc_instance++;
                                        }
                        }

                        return ("ExternalMovieClipLoader <loaders: " + loader_count + ", movieclips: " + mc_instance + ">"); 
                }

                public static function getMovieClipFromURL(url : String, mc_name : String = null, callBack : Function = null, duplicate : Boolean = false) : void {
                        
                        var loader : EmbedLoader;        

                        if(!loader_pool[url]){
                                loader = EmbedLoader.getLoader();
                                loader_pool[url] = loader;
                        }else{
                                loader = loader_pool[url];
                        }
                        
                        if(loader.status < 0){
                                loader.loadURL(url);
                                if(callBack != null) loader.callBacks.push({mc_name : mc_name, duplicate : duplicate, call_back : callBack});
                        }else if(loader.status > 0){
                                var mc : MovieClip;
                                var tf : uint;

                                if(mc_name && mc_name.length > 0){
                                        var res : MC = loader.getMovieClipByName(mc_name, duplicate) as MC;
                                        mc = res.mc;
                                        tf = res.fm;
                                }else{
                                        mc = loader.content as MovieClip;
                                        tf = mc.totalFrames;
                                }

                                if(callBack != null) callBack(mc, tf);

                        }else if(loader.status == 0){
                                if(callBack != null) loader.callBacks.push({mc_name : mc_name, duplicate : duplicate, call_back : callBack});
                        }
                }

                public static function recycle(url : String) : void {
                    if(loader_pool[url]) {
                        var loader : EmbedLoader = loader_pool[url];
                        loader.recycle();

                        loader = null;
                        delete loader_pool[url];
                    }
                }
        }
}


import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import flash.display.MovieClip;
import flash.utils.Dictionary;

import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

internal class EmbedLoader extends Loader {

        private var url : String;

        //-1:unloaded; 0:loading; 1:loaded
        public var status : int = -1;

        public var mc_pool : Dictionary = new Dictionary();
        public var linkage : Array = new Array();                        
        public var callBacks : Array = new Array();

        private var context : LoaderContext;

        private static var request : URLRequest = new URLRequest();
        private static var recycle_pool : Array = new Array();

        public function loadURL(url : String) : void {
                this.url = url;

                request = new URLRequest(url);
                context = new LoaderContext(false, new ApplicationDomain());

                contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
                contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);

                status = 0;
                load(request, context);
        }

        private function onLoaderComplete(evt : Event) : void {
                contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
                contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);

                status = 1;

                var len : int = callBacks.length;

                for (var j:uint = 0; j < len; j++) {
                        var callBack : Object = callBacks[j];

                        var f : Function = callBack['call_back'];
                        var n : String = callBack['mc_name'];
                        var d : Boolean = callBack['duplicate'];

                        if(n && n.length > 0){
                                var res : Object = getMovieClipByName(n, d);
                                f(res.mc, res.fm);
                        }else{
                                var mc : MovieClip = this.content as MovieClip; 
                                f(mc, mc.totalFrames);
                        }
                }

                callBacks = new Array();
        }

        private function onError(evt : IOErrorEvent) : void {
                recycle();
        }

        public function getMovieClipByName(mc_name : String, duplicate : Boolean = false) : Object {
                if(!mc_pool[mc_name] || duplicate){
                        if(status <= 0) return null;
                        try{
                                var mcClass : Class = contentLoaderInfo.applicationDomain.getDefinition( mc_name ) as Class;

                                var mc : MovieClip = new mcClass() as MovieClip;
                                var frames : int = mc.totalFrames;

                                var res : MC = new MC(mc, frames);
                                if(!duplicate) mc_pool[mc_name] = res;

                                return res;
                        } catch ( e : Error ) {
                                throw new Error('Can not find the movieclip <' + mc_name + '@' +  url + '>');
                        }
                }

                return mc_pool[mc_name];
        }

        public static function getLoader() : EmbedLoader {
                if(recycle_pool.length > 0)
                        return recycle_pool.shift();
                else
                        return new EmbedLoader();
        }

        public function recycle() : void {
                status = -1;

                contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
                contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);

                mc_pool = new Dictionary();
                callBacks = new Array();
                linkage = new Array();

                recycle_pool.push(this);
        }
}

internal class MC {
    public var mc : MovieClip = null;
    public var fm : uint = 0;

    public function MC(mc : MovieClip, fm : uint = 0) : void {
        this.mc = mc;
        this.fm = fm;
    }
}
