window.addEventListener("message",function(event){
	switch(event["data"]["action"]){
		case "Open":
			Request();
			$(".inventory").css("display","flex");
		break;

		case "Close":
			$(".inventory").css("display","none");
			$(".ui-tooltip").hide();
		break;

		case "Request":
			Request();
		break;
	}
});

$(document).ready(function(){
	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://inspect/Close");
			$(".invRight").html("");
			$(".invLeft").html("");
		}
	};
});

const updateDrag = () => {
	$(".populated").draggable({
		helper: "clone"
	});

	$('.empty').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data('amount'));

			if (shiftPressed)
				amount = itemAmount;
			else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
				amount = 1;
			else
				amount = parseInt($(".amount").val());

			if(amount > itemAmount)
				amount = itemAmount;

			$('.populated, .empty').off("draggable droppable");

			let clone1 = ui.draggable.clone();
			let slot2 = $(this).data("slot"); 

			if(amount == itemAmount){
				let clone2 = $(this).clone();
				let slot1 = ui.draggable.data("slot");

				$(this).replaceWith(clone1);
				ui.draggable.replaceWith(clone2);

				$(clone1).data("slot", slot2);
				$(clone2).data("slot", slot1);
			} else {
				let newAmountOldItem = itemAmount - amount;
				let weight = parseFloat(ui.draggable.data("peso"));
				let newWeightClone1 = (amount*weight).toFixed(3);
				let newWeightOldItem = (newAmountOldItem*weight).toFixed(3);

				ui.draggable.data("amount",newAmountOldItem);

				clone1.data("amount",amount);

				$(this).replaceWith(clone1);
				$(clone1).data("slot",slot2);

				ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(ui.draggable.data("amount")) + "x");
				ui.draggable.children(".top").children(".itemWeight").html(newWeightOldItem);

				$(clone1).children(".top").children(".itemAmount").html(formatarNumero(clone1.data("amount")) + "x");
				$(clone1).children(".top").children(".itemWeight").html(newWeightClone1);
			}

			updateDrag();

			if (origin === "invRight" && tInv === "invLeft"){
				$.post("http://inspect/Take",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invLeft" && tInv === "invRight"){
				$.post("http://inspect/Store",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			}

			$(".amount").val("");
		}
	});

	$('.populated').droppable({
		hoverClass: 'hoverControl',
		drop: function(event,ui){
			if(ui.draggable.parent()[0] == undefined) return;

			const shiftPressed = event.shiftKey;
			const origin = ui.draggable.parent()[0].className;
			if (origin === undefined) return;
			const tInv = $(this).parent()[0].className;

			itemData = { key: ui.draggable.data('item-key'), slot: ui.draggable.data('slot') };
			const target = $(this).data('slot');

			if (itemData.key === undefined || target === undefined) return;

			let amount = 0;
			let itemAmount = parseInt(ui.draggable.data('amount'));

			if (shiftPressed)
				amount = itemAmount;
			else if($(".amount").val() == "" | parseInt($(".amount").val()) <= 0)
				amount = 1;
			else
				amount = parseInt($(".amount").val());

			if(amount > itemAmount)
				amount = itemAmount;

			$('.populated, .empty, .use').off("draggable droppable");

			if(ui.draggable.data('item-key') == $(this).data('item-key')){
				let newSlotAmount = amount + parseInt($(this).data('amount'));
				let newSlotWeight = ui.draggable.data("peso") * newSlotAmount;

				$(this).data('amount',newSlotAmount);
				$(this).children(".top").children(".itemAmount").html(formatarNumero(newSlotAmount) + "x");
				$(this).children(".top").children(".itemWeight").html(newSlotWeight.toFixed(3));

				if(amount == itemAmount) {
					ui.draggable.replaceWith(`<div class="item empty" data-slot="${ui.draggable.data('slot')}"></div>`);
				} else {
					let newMovedAmount = itemAmount - amount;
					let newMovedWeight = parseFloat(ui.draggable.data("peso")) * newMovedAmount;

					ui.draggable.data('amount',newMovedAmount);
					ui.draggable.children(".top").children(".itemAmount").html(formatarNumero(newMovedAmount) + "x");
					ui.draggable.children(".top").children(".itemWeight").html(newMovedWeight.toFixed(3));
				}
			} else {
				if (origin === "invRight" && tInv === "invLeft") return;

				let clone1 = ui.draggable.clone();
				let clone2 = $(this).clone();

				let slot1 = ui.draggable.data("slot");
				let slot2 = $(this).data("slot");

				ui.draggable.replaceWith(clone2);
				$(this).replaceWith(clone1);

				$(clone1).data("slot",slot2);
				$(clone2).data("slot",slot1);
			}

			updateDrag();

			if (origin === "invRight" && tInv === "invLeft"){
				$.post("http://inspect/Take",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			} else if (origin === "invLeft" && tInv === "invRight"){
				$.post("http://inspect/Store",JSON.stringify({
					item: itemData.key,
					slot: itemData.slot,
					target: target,
					amount: parseInt(amount)
				}));
			}

			$(".amount").val("");
		}
	});

	$(".populated").tooltip({
		create: function(event,ui){
			$(this).tooltip({
				content: $(this).attr("data-description"),
				position: { my: "center top + 10", at: "center bottom", collision: "flipfit" },
				show: { duration: 10 },
				hide: { duration: 10 }
			});
		}
	});
}

const colorPicker = (percent) => {
	var colorPercent = "#2e6e4c";

	if (percent >= 100)
		colorPercent = "rgba(255,255,255,0)";

	if (percent >= 51 && percent <= 75)
		colorPercent = "#fcc458";

	if (percent >= 26 && percent <= 50)
		colorPercent = "#fc8a58";

	if (percent <= 25)
		colorPercent = "#fc5858";

	return colorPercent;
}

const Request = () => {
	$.post("http://inspect/Request",JSON.stringify({}),(data) => {
		$("#weightTextLeft").html(`${(data["invPeso"]).toFixed(3)}   /   ${(data["invMaxpeso"]).toFixed(3)}`);
		$("#weightTextRight").html(`${(data["chestPeso"]).toFixed(3)}   /   ${(data["chestMaxpeso"]).toFixed(3)}`);

		$("#weightBarLeft").html(`<div id="weightContent" style="width: ${data["invPeso"] / data["invMaxpeso"] * 100}%"></div>`);
		$("#weightBarRight").html(`<div id="weightContent" style="width: ${data["chestPeso"] / data["chestMaxpeso"] * 100}%"></div>`);

		$(".invLeft").html("");
		$(".invRight").html("");

		if (data["invMaxpeso"] > 100)
			data["invMaxpeso"] = 100;

		for (let x = 1; x <= data["invMaxpeso"]; x++){
			const slot = x.toString();

			if (data.myInventory[slot] !== undefined){
				const v = data.myInventory[slot];
				var maxDurability = 3600 * (v["days"] || 1);
				var newDurability = (maxDurability - (v["durability"] || 0)) / maxDurability;
				var actualPercent = newDurability * 100;

				if (v["charges"] !== undefined)
					actualPercent = v["charges"];

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `<div class="item populated" title="" style="background-image: url('nui://vrp/config/inventory/${v["index"]}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v["amount"]}" data-item-key="${v["key"]}" data-slot="${slot}" data-peso="${v["peso"]}" data-description="${v["desc"]}">
					<div class="top">
						<div class="itemWeight">${(v.peso * v.amount).toFixed(3)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>

					<div class="durability" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
					<div class="nameItem">${v.name}</div>
				</div>`;

				$(".invLeft").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invLeft").append(item);
			}
		}

		for (let x = 1; x <= data["chestMaxpeso"]; x++){
			const slot = x.toString();

			if (data.myChest[slot] !== undefined){
				const v = data.myChest[slot];
				var maxDurability = 3600 * (v["days"] || 1);
				var newDurability = (maxDurability - (v["durability"] || 0)) / maxDurability;
				var actualPercent = newDurability * 100;

				if (v["charges"] !== undefined)
					actualPercent = v["charges"];

				if (actualPercent <= 1)
					actualPercent = 1;

				const item = `<div class="item populated" title="" style="background-image: url('nui://vrp/config/inventory/${v["index"]}.png'); background-position: center; background-repeat: no-repeat;" data-amount="${v["amount"]}" data-item-key="${v["key"]}" data-slot="${slot}" data-peso="${v["peso"]}" data-description="${v["desc"]}" data-slot="${slot}">
					<div class="top">
						<div class="itemWeight">${(v.peso * v.amount).toFixed(3)}</div>
						<div class="itemAmount">${formatarNumero(v.amount)}x</div>
					</div>

					<div class="durability" style="width: ${actualPercent == 1 ? "100":actualPercent}%; background: ${actualPercent == 1 ? "#fc5858":colorPicker(actualPercent)};"></div>
					<div class="nameItem">${v.name}</div>
				</div>`;

				$(".invRight").append(item);
			} else {
				const item = `<div class="item empty" data-slot="${slot}"></div>`;

				$(".invRight").append(item);
			}
		}

		updateDrag();
	});
}

const formatarNumero = n => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}