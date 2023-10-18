_:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "monokai";
      editor = {
        cursor-shape = {
          insert = "bar";
	        normal = "block";
	        select = "underline";
	      };
      };
    };
  };
}
