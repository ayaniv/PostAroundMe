<%@ Page Language="C#" AutoEventWireup="true" CodeFile="flip.aspx.cs" Inherits="Pages_DateTimeTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

   <script src="../scripts/compress/flipcard-utils.js"></script>
  <script src="../scripts/compress/flip-card.js"></script>
      <link rel="stylesheet" href="../css/flip-card.css" media="screen" />

    <style type="text/css">
 .container {
      width: 200px;
      height: 260px;
      position: relative;
      margin: 0 auto 40px;
      border: 1px solid #CCC;
      -webkit-perspective: 800px;
         -moz-perspective: 800px;
           -o-perspective: 800px;
              perspective: 800px;
    }

    #card {
      width: 100%;
      height: 100%;
      position: absolute;
      -webkit-transition: -webkit-transform 1s;
         -moz-transition: -moz-transform 1s;
           -o-transition: -o-transform 1s;
              transition: transform 1s;
      -webkit-transform-style: preserve-3d;
         -moz-transform-style: preserve-3d;
           -o-transform-style: preserve-3d;
              transform-style: preserve-3d;
    }

    #card.flipped {
      -webkit-transform: rotateY( 180deg );
         -moz-transform: rotateY( 180deg );
           -o-transform: rotateY( 180deg );
              transform: rotateY( 180deg );
    }

    #card figure {
      display: block;
      height: 100%;
      width: 100%;
      line-height: 260px;
      color: white;
      text-align: center;
      font-weight: bold;
      font-size: 140px;
      position: absolute;
      -webkit-backface-visibility: hidden;
         -moz-backface-visibility: hidden;
           -o-backface-visibility: hidden;
              backface-visibility: hidden;
    }

    #card .front {
      background: red;
    }

    #card .back {
      background: blue;
      -webkit-transform: rotateY( 180deg );
         -moz-transform: rotateY( 180deg );
           -o-transform: rotateY( 180deg );
              transform: rotateY( 180deg );
    }
        </style>
</head>
<body>
    
    <div>
    
    </div>






<div class="container">
  <div id="card">
    <div class="front">1</div>
    <div class="back">2</div>
  </div>
</div>

        

        <div id="options">
    <p><div id="flip">Flip Card</div></p>
  </div>


 
</body>
</html>
