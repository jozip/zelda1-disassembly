.segment "HEADER"
  .byte 'N', 'E', 'S', $1A ; Magic bytes
  .byte $08                ; PRG size in 16k units
  .byte $00                ; CHR size in 8k units
  .byte %00010010          ; iNES flag 6
  ;      ||||||||
  ;      |||||||+----------- Horizontal mirroring (CIRAM A10 = PPU A11)
  ;      ||||||+------------ Contains battery-backed persistent memory
  ;      |||||+------------- No trainer
  ;      ||||+-------------- Do not ignore mirroring bit
  ;      ++++--------------- Use MMC1 mapper
  .byte $00, $00, $00, $00, $00, $00
