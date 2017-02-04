//
//  Pdf_Viewer.m
//  CarBo
//
//  Created by Shirish Vispute on 28/07/16.
//  Copyright © 2016 Bitware Technologies. All rights reserved.
//

#import "Pdf_Viewer.h"

@interface Pdf_Viewer ()
{
 UIWebView *baseImage;
}
@end

@implementation Pdf_Viewer

- (void)viewDidLoad 
{
    [super viewDidLoad];
    
//  http://files.harpercollins.com/Mktg/ItBooks/FortyStories.pdf
    
}

// Working code tutsplus
// http://code.tutsplus.com/tutorials/ios-sdk-previewing-and-opening-documents--mobile-15130


- (void)drawLayer: (CALayer*)layer inContext: (CGContextRef) context
{
    //code 1
//    CGAffineTransform currentCTM = CGContextGetCTM(context);    
//    if (currentCTM.a == 1.0 && baseImage) {
//        //Calculate ideal scale
//        CGFloat scaleForWidth = baseImage.size.width/self.bounds.size.width;
//        CGFloat scaleForHeight = baseImage.size.height/self.bounds.size.height; 
//        CGFloat imageScaleFactor = MAX(scaleForWidth, scaleForHeight);
//        
//        CGSize imageSize = CGSizeMake(baseImage.size.width/imageScaleFactor, baseImage.size.height/imageScaleFactor);
//        CGRect imageRect = CGRectMake((self.bounds.size.width-imageSize.width)/2, (self.bounds.size.height-imageSize.height)/2, imageSize.width, imageSize.height);
//        CGContextDrawImage(context, imageRect, [baseImage CGImage]);
//    } else {
//        @synchronized(issue) { 
//            CGPDFPageRef pdfPage = CGPDFDocumentGetPage(issue.pdfDoc, pageIndex+1);
//            pdfToPageTransform = CGPDFPageGetDrawingTransform(pdfPage, kCGPDFMediaBox, layer.bounds, 0, true);
//            CGContextConcatCTM(context, pdfToPageTransform);    
//            CGContextDrawPDFPage(context, pdfPage);
//        }
//    }
}

//Code 2 URL --http://www.cocoabuilder.com/archive/cocoa/196313-display-pdf-in-calayer.html 
//PDFPainter = [[CBDocumentPDFDelegate alloc] initWithPDF: pdf page:
//              pageNum];
//pdfHolder = [[CALayer alloc] init];
//pdfHolder.bounds = [pdfHolder convertRect: self.bounds fromLayer: self];
//CGPoint innerPos = CGPointMake( CGRectGetMidX(self.bounds),
//                               CGRectGetMidY(self.bounds));
//pdfHolder.position = innerPos;
//
//[pdfHolder setDelegate: PDFPainter];
//pdfHolder.needsDisplayOnBoundsChange = YES;
//[pdfHolder setNeedsDisplay];
//[self addSublayer: (id) pdfHolder];
//
//Here is the drawing code from the CBDocumentPDFDelegate class:
//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)theContext {
//    
//    CGColorRef background = CGColorGetConstantColor(kCGColorWhite);
//    layer.backgroundColor = background;
//    
//    CGPDFPageRef page = CGPDFDocumentGetPage(layerPDF, currentPage);
//    
//    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page,
//                                                                  kCGPDFMediaBox,layer.bounds, 0, true);
//    CGContextSaveGState (theContext);
//    CGContextConcatCTM (theContext, pdfTransform);
//    CGContextClipToRect (theContext, CGPDFPageGetBoxRect(page,
//                                                         kCGPDFMediaBox));
//    CGContextDrawPDFPage(theContext,page);
//    CGContextRestoreGState (theContext);
//}

//Code 3
//-(UIImage *)renderPDFPageToImage:(int)pageNumber//NSOPERATION?
//{
//    //you may not want to permanently (app life) retain doc ref
//    
//    CGSize size = CGSizeMake(x,y);     
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    CGContextTranslateCTM(context, 0, 750);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    
//    CGPDFPageRef page;  //Move to class member 
//    
//    page = CGPDFDocumentGetPage (myDocumentRef, pageNumber);
//    CGContextDrawPDFPage (context, page);
//    
//    UIImage * pdfImage = UIGraphicsGetImageFromCurrentImageContext();//autoreleased
//    UIGraphicsEndImageContext();
//    return pdfImage;
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
