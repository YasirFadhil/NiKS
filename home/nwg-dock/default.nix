{ pkgs,  ...}: {
  home.packages = with pkgs;[nwg-dock-hyprland];

  xdg.configFile."nwg-dock-hyprland/style.css".text  =  ''
    window {
    /*  background: rgba(99, 100, 127, 0.9);*/
    background: rgba(30, 30, 46, 0.6);
    border-radius: 25px;
    border-style: solid;
    border-width: 0px;
    /*	border-width:0px;*/
    /*	border-color: #947A86;*/
    border-color: #f4b8e4;
    /*	border-bottom: none;*/
   /* border-bottom-right-radius: 70px;
    border-bottom-left-radius: 70px; */ 
    /*	border-color: #B1ABB9;*/
  }

  #box {
  /* Define attributes of the box surrounding icons here */
  /*    background : rgba(33, 26, 38, 0.2);*/
  padding: 8px;
  margin-left: 15px;
  margin-right: 15px;
  margin-bottom: 5px;
  margin-top: 5px;
  border-radius: 10px;
  border-bottom-right-radius: 70px;
  border-bottom-left-radius: 70px;
  }

  #active {
  /* This is to underline the button representing the currently active window */
  /*	border: solid 2px;*/
  border-radius: 10px;
  /*	border-color: rgba(203, 166, 247, 0.9);*/
  /*	background: rgba(221, 120, 120,0.4);*/
  background: rgba(102, 99, 116, 0.6);
  }

  button, image {
    background: none;
    border-style: none;
    box-shadow: none;
    color: #e64553;
  }

  button {
    /*    border: 1px solid rgba(184, 119, 128, 0.7);*/
  }

  button {
    padding: 4px;
    margin-left: 4px;
    margin-right: 4px;
    color: #e64553;
    font-size: 11px;
  } 

  button:hover {
    border-radius: 8px;
    background-color: rgba(204, 208, 218,1);
  } 

  button:focus {
    box-shadow: none
  }
  '';
}
