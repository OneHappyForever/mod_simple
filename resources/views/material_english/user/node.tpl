







{include file='user/main.tpl'}


<script src="//cdn.staticfile.org/canvasjs/1.7.0/canvasjs.js"></script>
<script src="//cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>

	<main class="content">
		<div class="content-header ui-content-header">
			<div class="container">
				<h1 class="content-heading">Server List</h1>
			</div>
		</div>
		<div class="container">
			<section class="content-inner margin-top-no">
				<div class="row">
					<div class="col-lg-12 col-md-12">
						<div class="card margin-bottom-no">
							<div class="card-main">
								<div class="card-inner">
									<h4>Important:</h4>
									<p>Do not share the servers publicly!</p>
									<p></p>
									<a href="javascript:void(0);" onClick="urlChange('guide',0,0,0)">If you do not know how to view the server details and QR Codes, please click me.</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="ui-card-wrap">
					<div class="row">
						<div class="col-lg-12 col-sm-12">
							<div class="card">
								<div class="card-main">
									<div class="card-inner margin-bottom-no">
										<div class="tile-wrap">
											{$id=0}
											{foreach $node_prefix as $prefix => $nodes}
												{$id=$id+1}

													<div class="tile tile-collapse">
														<div data-toggle="tile" data-target="#heading{$node_order->$prefix}">
															<div class="tile-side pull-left" data-ignore="tile">
																<div class="avatar avatar-sm">
																	<span class="icon {if $node_heartbeat[$prefix]=='Online'}text-green{else}{if $node_heartbeat[$prefix]=='No Data'}text-orange{else}text-red{/if}{/if}">{if $node_heartbeat[$prefix]=="Online"}backup{else}{if $node_heartbeat[$prefix]=='No Data'}report{else}warning{/if}{/if}</span>
																</div>
															</div>
															<div class="tile-inner">
																<div class="text-overflow"><font color="#B7B7B7">{$prefix}</font> <!--| <i class="icon icon-lg">person</i> <strong><b><font color="red">{$node_alive[$prefix]}</font></b></strong>--> | <i class="icon icon-lg">build</i>  <font color="#CD96CD">{$node_method[$prefix]}</font> | <i class="icon icon-lg">traffic</i> {if isset($node_bandwidth[$prefix])==true}<font color="#C1CDC1">{$node_bandwidth[$prefix]}</font>{else}N/A{/if}</div>
															</div>
														</div>
														<div class="collapsible-region collapse" id="heading{$node_order->$prefix}">
															<div class="tile-sub">

																<br>

																{foreach $nodes as $node}

																	{$relay_rule = null}
																	{if $node->sort == 10}
																		{$relay_rule = $tools->pick_out_relay_rule($node->id, $user->port, $relay_rules)}
																	{/if}

																	{if $node->mu_only != 1}
																	<div class="card">
																		<div class="card-main">
																			<div class="card-inner">
																			<p class="card-heading" >
																				<a href="javascript:void(0);" onClick="urlChange('{$node->id}',0,{if $relay_rule != null}{$relay_rule->id}{else}0{/if})">{$node->name}{if $relay_rule != null} - {$relay_rule->dist_node()->name}{/if}</a>
																				<span class="label label-brand-accent">{$node->status}</span>
																			</p>


																			{if $node->sort > 2 && $node->sort != 5 && $node->sort != 10}
																				<p>Address：<span class="label" >
																				<a href="javascript:void(0);" onClick="urlChange('{$node->id}',0,0)">Please click here to view details</a>
																			{else}
																				<p>Address：<span class="label label-brand-accent">
																				{$node->server}
																			{/if}

																				</span></p>

																			{if $node->sort == 0||$node->sort==7||$node->sort==8||$node->sort==10}


																				<p>Data ratio：<span class="label label-red">
																					{$node->traffic_rate}
																				</span></p>



																				{if ($node->sort==0||$node->sort==7||$node->sort==8||$node->sort==10)&&($node->node_speedlimit!=0||$user->node_speedlimit!=0)}
																					<p>Server speed limit：<span class="label label-green">
																						{if $node->node_speedlimit>$user->node_speedlimit}
																							{$node->node_speedlimit}Mbps
																						{else}
																							{$user->node_speedlimit}Mbps
																						{/if}
																					</span></p>
																				{/if}
																			{/if}

																			<p>{$node->info}</p>

																			 </div>

																		</div>
																	</div>
																	{/if}

																	{if $node->sort == 0 || $node->sort == 10}
																		{$point_node=$node}
																	{/if}



																	{if ($node->sort == 0 || $node->sort == 10) && $node->custom_rss == 1 && $node->mu_only != -1}
																		{foreach $node_muport as $single_muport}

																			{if !($single_muport['server']->node_class <= $user->class && ($single_muport['server']->node_group == 0 || $single_muport['server']->node_group == $user->node_group))}
																				{continue}
																			{/if}

																			{if !($single_muport['user']->class >= $node->node_class && ($node->node_group == 0 || $single_muport['user']->node_group == $node->node_group))}
																				{continue}
																			{/if}

																			{$relay_rule = null}
																			{if $node->sort == 10 && $single_muport['user']['is_multi_user'] != 2}
																				{$relay_rule = $tools->pick_out_relay_rule($node->id, $single_muport['server']->server, $relay_rules)}
																			{/if}

																			<div class="card">
																				<div class="card-main">
																					<div class="card-inner">
																					<p class="card-heading" >
																						<a href="javascript:void(0);" onClick="urlChange('{$node->id}',{$single_muport['server']->server},{if $relay_rule != null}{$relay_rule->id}{else}0{/if})">{$prefix} {if $relay_rule != null} - {$relay_rule->dist_node()->name}{/if} - 单端口多用户 Shadowsocks - {$single_muport['server']->server} 端口</a>
																						<span class="label label-brand-accent">{$node->status}</span>
																					</p>


																					<p>Address：<span class="label label-brand-accent">
																					{$node->server}

																					</span></p>

																					<p>Port：<span class="label label-brand-red">
																						{$single_muport['user']['port']}
																					</span></p>

																					<p>Encryption：<span class="label label-brand">
																						{$single_muport['user']['method']}
																					</span></p>

																					<p>Protocol：<span class="label label-brand-accent">
																						{$single_muport['user']['protocol']}
																					</span></p>

																					{if $single_muport['user']['is_multi_user'] != 0}
																					<p>Protocol parameters：<span class="label label-green">
																						{$user->id}:{$user->passwd}
																					</span></p>
																					{/if}

																					<p>Obfuscation：<span class="label label-brand">
																						{$single_muport['user']['obfs']}
																					</span></p>

																					{if $single_muport['user']['is_multi_user'] == 1}
																					<p>Obfuscation parameters：<span class="label label-green">
																						{$single_muport['user']['obfs_param']}
																					</span></p>
																					{/if}

																					<p>Data ratio：<span class="label label-red">
																						{$node->traffic_rate}
																					</span></p>

																					<p>{$node->info}</p>

																					 </div>

																				</div>
																			</div>
																		{/foreach}
																	{/if}
																{/foreach}



																{if isset($point_node)}
																	{if $point_node!=null}

																		<div class="card">
																			<div class="card-main">
																				<div class="card-inner" id="info{$id}">

																				</div>
																			</div>
																		</div>

																		<script>
																		$().ready(function(){
																			$('#heading{$node_order->$prefix}').on("shown.bs.tile", function() {

																				$("#info{$id}").load("/user/node/{$point_node->id}/ajax");

																			});
																		});
																		</script>
																	{/if}
																{/if}

																{$point_node=null}




															</div>



														</div>



												</div>

											{/foreach}
										</div>
									</div>

								</div>
							</div>
						</div>

						<div aria-hidden="true" class="modal modal-va-middle fade" id="nodeinfo" role="dialog" tabindex="-1">
							<div class="modal-dialog modal-full">
								<div class="modal-content">
									<iframe class="iframe-seamless" title="Modal with iFrame" id="infoifram"></iframe>
								</div>
							</div>
						</div>
					</div>
				</div>
			</section>
		</div>
	</main>







{include file='user/footer.tpl'}


<script>


function urlChange(id,is_mu,rule_id) {
    var site = './node/'+id+'?ismu='+is_mu+'&relay_rule='+rule_id;
	if(id == 'guide')
	{
		var doc = document.getElementById('infoifram').contentWindow.document;
		doc.open();
		doc.write('<img src="https://www.zhaoj.in/wp-content/uploads/2016/07/1469595156fca44223cf8da9719e1d084439782b27.gif" style="width: 100%;height: 100%; border: none;"/>');
		doc.close();
	}
	else
	{
		document.getElementById('infoifram').src = site;
	}
	$("#nodeinfo").modal();
}
</script>
