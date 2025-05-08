{
  plugins.cmp = {
    enable = true;
      autoEnableSources = true;
      settings.sources = [
	{name = "nvim_lsp";}
	{name = "path";}
	{name = "buffer";}
	{name = "luasnip";}
      ];
    
    settings.mapping = {
      "<Tab>" = ''
        cmp.mapping(
          function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end
	)
     '';	
    };
  };
}
