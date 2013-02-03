package eu.riasol.coloring.view.qnx {
	import com.adobe.serialization.json.JSON;
	
	import eu.riasol.coloring.application.ColoringEvent;
	import eu.riasol.coloring.application.ColoringEventDispatcher;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	
	import flashprolib.apis.IJsonDecored;
	import flashprolib.apis.google.GoogleApiEvent;
	import flashprolib.apis.google.GoogleApisCommon;
	import flashprolib.apis.google.ImageSearch;
	import flashprolib.apis.google.Query;
	import flashprolib.apis.google.Rest;
	import flashprolib.apis.google.RszEnum;
	
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.buttons.SegmentedControl;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.data.DataProvider;
	import qnx.ui.events.ListEvent;
	import qnx.ui.listClasses.ListSelectionMode;
	import qnx.ui.listClasses.TileList;
	import qnx.ui.text.Label;
	import qnx.ui.text.TextInput;

	public class GoogleSearchComponent extends Container implements IJsonDecored {
		private var list:SegmentedControl
		private var firstSeach:Boolean
		private var lastP:uint=0;
		private var searchInput:TextInput;
		private var tile:TileList;
		public function GoogleSearchComponent(s:Number=100, su:String="percent") {
			super(s, su);
			CONFIG::debug {
				debugColor=0x0000ff
			}
			padding=6
			flow=ContainerFlow.VERTICAL
			var l:Label=new Label();
			l.text='search image on internet';
			l.width=400
			addChild(l);
			var searchContainer:Container=new Container()
			searchContainer.padding=6
			searchContainer.flow=ContainerFlow.HORIZONTAL
			searchContainer.size=10
			searchContainer.sizeUnit=SizeUnit.PERCENT;
			addChild(searchContainer)
			searchInput=new TextInput()
			searchContainer.addChild(searchInput)
			searchInput.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void{
				if(e.keyCode==Keyboard.ENTER){
					onSearchClick()
				}
			})
			var b:LabelButton=new LabelButton()
			b.label='search'
			b.addEventListener(MouseEvent.CLICK, onSearchClick)
			searchContainer.addChild(b)
			tile=new TileList()
			
			tile.columnCount=4
			tile.rowHeight=150
			tile.rowCount=2	
			tile.cellPadding=5;
			tile.size=100
			tile.sizeUnit=SizeUnit.PERCENT;
			tile.sizeMode=SizeMode.BOTH;
			tile.selectionMode=ListSelectionMode.SINGLE;
			tile.setSkin(ImageCellRenderer)
			tile.addEventListener(ListEvent.ITEM_CLICKED, onImageClicked)
			addChild(tile)
			list=new SegmentedControl()
			list.alpha=0
			list.addEventListener(Event.CHANGE, onPageChange)
			addChild(list)
			GoogleApisCommon.getInstance().rsz=new RszEnum(RszEnum.TYPE_LARGE)
		}
		private function performSearch(p:uint=0):void {
			lastP=p
			var rest:Rest=new Rest(new ImageSearch())
			rest.externalJsonDecoder=this
			rest.addEventListener(GoogleApiEvent.EVENT_RESULT_COMPLETE, onSearchResult)
			var q:Query=new Query()
			q.q=searchInput.text
			rest.run(q, p)
		}
		private function onSearchResult(e:GoogleApiEvent):void {
			tile.columnWidth=width / tile.columnCount
			tile.dataProvider=new DataProvider(e.queryResult)
			if(firstSeach) {
				firstSeach=false
				list.dataProvider=new DataProvider(e.cursor.pages)
				if(e.cursor.pages is Array && e.cursor.pages.length>0){
					list.selectedIndex=0	
				}	
				list.alpha=1
			}
		}
		private function onPageChange(e:Event=null):void {
			performSearch(SegmentedControl(e.currentTarget).selectedItem.start)
		}
		private function onSearchClick(e:MouseEvent=null):void {
			if(searchInput.text.length<1){
				return
			}
			firstSeach=true
			performSearch()
		}
		public function decode(input:String):Object {
			return JSON.decode(input)
		}
		private function onImageClicked(e:ListEvent):void {
			var ev:ColoringEvent=new ColoringEvent(ColoringEvent.EVENT_IMAGE_SELECT)
			ev.data={image:e.data.url}
			ColoringEventDispatcher.instance.dispatchEvent(ev)
		}
	}
}