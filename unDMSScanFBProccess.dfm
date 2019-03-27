object frmDMSScanFBProccess: TfrmDMSScanFBProccess
  Left = 0
  Top = 289
  AutoScroll = False
  Caption = 'frmDMSScanFBProccess'
  ClientHeight = 50
  ClientWidth = 492
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gg: TGauge
    Left = 9
    Top = 9
    Width = 454
    Height = 25
    Progress = 0
  end
  object PRPage1: TPRPage
    Left = 12
    Top = 139
    Width = 596
    Height = 842
    MarginTop = 32
    MarginLeft = 32
    MarginRight = 32
    MarginBottom = 32
    object PRLayoutPanel1: TPRLayoutPanel
      Left = 17
      Top = 15
      Width = 562
      Height = 810
      object PRJpegImage1: TPRJpegImage
        Left = 0
        Top = 0
        Width = 562
        Height = 810
        Align = alClient
        SharedImage = False
      end
    end
  end
  object PRPage2: TPRPage
    Left = 278
    Top = 385
    Width = 842
    Height = 596
    MarginTop = 32
    MarginLeft = 32
    MarginRight = 32
    MarginBottom = 32
    object PRLayoutPanel2: TPRLayoutPanel
      Left = 33
      Top = 33
      Width = 776
      Height = 530
      Align = alClient
      object PRJpegImage2: TPRJpegImage
        Left = 0
        Top = 0
        Width = 776
        Height = 530
        Align = alClient
        SharedImage = False
      end
    end
  end
  object PReport1: TPReport
    FileName = 'default.pdf'
    CreationDate = 40827.6987366088
    UseOutlines = False
    ViewerPreference = [vpFitWindow, vpCenterWindow]
    Left = 426
    Top = 1
  end
end
