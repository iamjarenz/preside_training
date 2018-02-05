<cfscript>
    param name="args.subject"          type="string" default="";
    param name="args.body"             type="string" default="";
    param name="args.read_online_link" type="string" default="";
</cfscript>
<cfoutput>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>General Email</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style type="text/css">
            /* Client-specific Styles */

            ##outlook a {
                padding: 0;
            }

            body {
                width: 100% !important;
                -webkit-text-size-adjust:100%;
                -ms-text-size-adjust: 100%;
                margin: 0;
                padding: 0;
            }

            div, p, a, li, td {
                -webkit-text-size-adjust: none;
                -ms-text-size-adjust: none;
            }

            .ExternalClass {
                width:100%;
            }

            .ExternalClass,
            .ExternalClass p,
            .ExternalClass span,
            .ExternalClass font,
            .ExternalClass td,
            .ExternalClass div {
                line-height: 100%;
            }

            img {
                outline: none;
                text-decoration: none;
                border: none;
                -ms-interpolation-mode: bicubic;
            }

            a img {
                border: none;
            }

            .image_fix {
                display: block;
            }

            table td {
                border-collapse: collapse;
            }

            table {
                border-collapse: collapse;
                mso-table-lspace: 0pt;
                mso-table-rspace: 0pt;
            }

            body {
                background : ##f4f4f4;
            }

            body,
            p {
                font-family : 'Arial', sans-serif;
                color       : ##2d2d2d;
                font-size   : 14px;
                line-height : 22px;
                font-weight : 400;
            }

            p {
                margin-top    : 0;
                margin-bottom : 20px;
            }

            h1 {
                font-size: 32px;
            }

            h2 {
                font-size: 28px;
            }

            h3 {
                font-size: 24px;
            }

            h4 {
                font-size: 16px;
            }

            h5 {
                font-size: 12px;
            }

            h6 {
                font-size: 10px;
            }

            h1, h2, h3, h4, h5, h6 {
                font-family   : 'Arial', sans-serif;
                line-height   : 1.2;
                color         : ##2d2d2d;
                margin-top    : 0;
                margin-bottom : 15px;
            }

            a {
                font-family     : 'Arial', sans-serif;
                text-decoration : none;
                color           : ##577db1;
                cursor          : pointer;
                font-weight     : 700;
            }

            img {
                display: block;
                border: none;
                max-width: 100% !important;
            }

            /*HEADER*/
            .header {
                background: ##fff;
                padding: 30px 60px 0;
                width:100%;
            }
                .header-table {
                    vertical-align: middle;
                    width: 100%;
                }
                .header-logo,
                .header-link {
                    width: 50%;
                    padding-bottom: 20px;
                }
                .header-logo {
                    color: ##428bca;
                    font-size: 24px;
                    font-weight: bold;
                }

            /*EMAIL CONTAINER*/
            .email-container {
                background: ##fff;
                padding: 0 60px;
            }

                .main-content {
                    padding: 30px 0 20px;
                    border-top: 1px solid ##bfbfbf;
                    border-bottom: 1px solid ##bfbfbf;

                }

                .buttonWrapper {
                    width: 140px;
                    margin-bottom: 5px;
                    margin-left: auto;
                    margin-right: auto;
                }

                    .btn {
                        border-radius: 50px;
                        text-align: center;
                        font-family:  'Arial', sans-serif;
                        font-size: 14px;
                        font-weight: bold;
                        line-height: 18px;
                        color: ##ffffff;
                        text-decoration: none;
                        padding: 16px 20px;
                        background-color: ##577db1;
                    }
                    .btn-link {
                        color: ##ffffff;
                        text-decoration: none;
                        font-weight: bold;
                    }

            /*FOOTER*/
            .footer {
                background: ##fff;
                padding: 20px 60px 20px;
                width: 100%;
            }
                .footer-content {
                    width: 100%;
                    text-align: center;
                }
                .footer-social {
                    padding-top: 20px;
                }
                .footer-social a {
                    display: inline-block;
                }

            /*BANNER*/
            .banner-img {

            }
                .banner-img a {
                    display: block;
                    width: 100%;
                }
                .banner-img img {
                    display: block;
                    width: 100% !important;
                    height: auto !important;
                    max-height: none !important;
                }
            .banner-content {
                background: ##fff;
                padding: 30px 60px 20px;
                text-align: center;
            }


            /*WDGET*/
            .email-widget {
                margin-bottom: 10px;
                width: 100%;
            }

            /*WDGET COLUMNS*/
            .widget-column {
                width: 50%;
                vertical-align: top;
                padding-bottom: 20px;
            }
                .widget-column.column-left {
                    padding-right: 15px;
                }
                .widget-column.column-right {
                    padding-left: 15px;
                }

            /*ARTICLES*/
            .email-article {
            }
                .article-img {
                    padding-bottom: 15px;
                }
                    .article-img a {
                        text-align: center;
                        display: block;
                    }
                    .article-img img {
                        display: inline-block;
                    }
                .article-meta {
                    font-size: 12px;
                    padding-bottom: 5px;
                    color: ##7f7f7f;
                }
                .article-title {
                    font-size: 21px;
                    line-height: 1.2;
                    padding-bottom: 10px;
                }
                    .article-title a {
                        color: ##2d2d2d;
                    }
                .article-location {
                    font-weight: 700;
                    color: ##7f7f7f;
                    font-size: 12px;
                    line-height: 16px;
                    padding-bottom: 5px;
                }
                .article-excerpt {
                }
                .article-excerpt p {
                    margin: 0;
                    line-height: 22px;
                }
                .article-category {
                    padding-top: 15px;

                }
                    .category {
                        width: 180px;
                    }
                        .category-btn {
                            border-radius: 50px;
                            text-align: center;
                            font-family:  'Arial', sans-serif;
                            font-size: 13px;
                            font-weight: 700;
                            line-height: 18px;
                            color: ##ffffff;
                            text-decoration: none;
                            padding: 6px 4px;
                            background: ##0e1c2c;
                        }
                            .tag {
                                color: ##ffffff;
                            }
            .widget-listing-img {
                width: 40%;
                padding-right: 15px;
                padding-bottom: 20px;
                vertical-align: top;
            }
                .widget-listing-img .email-article {
                    margin-bottom: 0;
                }
            .widget-listing-details {
                width: 60%;
                padding-left: 15px;
                padding-bottom: 20px;
                vertical-align: top;
            }
                .widget-listing-details .email-article {
                    margin-bottom: 0;
                }


            @media only screen and (max-width: 640px), only screen and (max-device-width: 640px) {
                table[id=main-table],
                table##main-table {
                    width: 440px !important;
                }

                td[class=header],
                td.header {
                    padding-left: 30px !important;
                    padding-right: 30px !important;
                }
                td[class=banner-content],
                td.banner-content {
                    padding-left: 30px !important;
                    padding-right: 30px !important;
                }
                td[class=banner-img] img,
                td.banner-img img{
                    height: auto !important;
                }
                td[class=email-container],
                td.email-container {
                    padding-left: 30px !important;
                    padding-right: 30px !important;
                }
                td[class=footer],
                td.footer {
                    padding-left: 30px !important;
                    padding-right: 30px !important;
                }
                td[class=article-img],
                td.article-img {
                    text-align: center;
                }
                td[class=widget-column],
                td.widget-column {
                    width: 100% !important;
                    padding: 0 !important;
                    display: block !important;
                }
                td[class=widget-listing-img],
                td.widget-listing-img {
                    width: 100% !important;
                    padding: 0 0 20px !important;
                    display: block !important;
                }
                td[class=widget-listing-details],
                td.widget-listing-details {
                    width: 100% !important;
                    padding: 0 0 20px !important;
                    display: block !important;
                }

            }
            @media only screen and (max-width: 480px), only screen and (max-device-width: 480px) {
                table[id=main-table],
                table##main-table {
                    width: 320px !important;
                }
            }
        </style>
    </head>
    <body>
        <table border="0" cellpadding="0" cellspacing="0" width="600" align="center" id="main-table">

            <tr>
                <td class="header">
                    <table class="header-table" border="0" cellpadding="0" cellspacing="0" align="center">
                        <tr>
                            <td align="left" class="header-logo">
                                Training Logo
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td class="email-container">
                    <table class="header-table" border="0" cellpadding="0" cellspacing="0" align="center">
                        <tr>
                            <td class="main-content">
                                #args.body#
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

            <tr>
                <td class="footer" align="left">
                    <table class="footer-content" border="0" cellpadding="0" cellspacing="0" align="center">
                        <tr>
                            <td>
                                <p>
                                    <strong>This is the footer</strong> <br />
                                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. <br /> 
                                    Animi ex saepe laboriosam

                                </p>
                            </td>
                        </tr>

                    </table>
                </td>
            </tr>

        </table>
    </body>
    </html>
</cfoutput>