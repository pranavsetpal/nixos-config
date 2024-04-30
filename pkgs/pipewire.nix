{ pkgs, ... }: {
	home = {
		packages = with pkgs; [ rnnoise-plugin ];
		file.".config/pipewire/pipewire.conf.d/99-input-denoising.conf".source =
			let
				json = pkgs.formats.json {};
				input_denoising_99 = {
					"context.modules" = [{
						"name" = "libpipewire-module-filter-chain";
						"args" = {
							"node.description" = "Microphone (Inbuilt) - Noise Suppressed";
							"media.name" = "Microphone (Inbuilt) - Noise Suppressed";
							"filter.graph" = {
								"nodes" = [{
									"type" = "ladspa";
									"name" = "rnnoise";
									"plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
									"label" = "noise_suppressor_mono";
									"control" = {
										"VAD Threshold (%)" = 50.0;
										"VAD Grace Period (ms)" = 200;
										"Retroactive VAD Grace (ms)" = 0;
									};
								}];
							};
							"capture.props" = {
								"node.name" =	"capture.rnnoise_source";
								"node.passive" = true;
								"audio.rate" = 48000;
							};
							"playback.props" = {
								"node.name" =	"rnnoise_source";
								"media.class" = "Audio/Source";
								"audio.rate" = 48000;
							};
						};
					}];
				};
			in
				json.generate "99-input-denoising.conf" input_denoising_99;
	};
}
