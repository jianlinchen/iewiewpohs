//
//  XSecKeyWrapper.h
//

#import <UIKit/UIKit.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

// Global constants for padding schemes.
#define	kPKCS1					11
#define kTypeOfSigPadding		kSecPaddingPKCS1

@interface SecKeyWrapper : NSObject
{
    
}

/*
    数字签名验证
    @param plainText   明文数据
    @param publicKey   公钥指针
    @param sig         签名
    @returns 验证成功返回YES，否则返回NO。
 */
+ (BOOL)verifySignature:(NSData *)plainText secKeyRef:(SecKeyRef)publicKey signature:(NSData *)sig;

/*
    公钥加密
    @param plainText   明文数据
    @param publicKey   公钥数据
    @returns 加密成功返回加密后的数据，否则返回nil。
 */
+ (NSData*)encrypt1:(NSData*)plainText publicKey:(NSString*)key;
+ (NSData*)encrypt:(NSData*)plainText publicKey:(NSData*)key;
+(NSData*)decryptString:(NSData*)original RSAPrivateKey:(SecKeyRef)privateKey;
/*
    添加公钥
    @param keyName   公钥的名字
    @param keyString 字符串形式的公钥
    @returns 公钥的指针
 */

+ (SecKeyRef)addPublicKey:(NSString*)keyName keyString:(NSString*)keyString;

/*
    去掉公钥的头部填充数据
    @param keyData    公钥的原始数据
    @returns 公钥被处理后的数据
 */
+ (NSData *)stripPublicKeyHeader:(NSData *)keyData;

/*
    添加公钥
    @param keyName   公钥名称
    @param publicKey 公钥的bytes格式的数据
    @returns 公钥的指针
 */
+ (SecKeyRef)addPublicKey:(NSString *)keyName keyBits:(NSData *)publicKey;

/*
    获取持久化的公钥对应的公钥指针
    @param keyName   持久化的公钥指针
    @returns 公钥的指针
 */
+ (SecKeyRef)getKeyRefWithPersistentKeyRef:(CFTypeRef)persistentRef;

/*
    获取明文的hash值，采用sha1算法
    @param plainText   明文数据
    @returns 明文的hash值
 */
+ (NSData *)getHashBytes:(NSData *)plainText;

/*
    删除公钥
    @param keyName   公钥的名称
 */
+ (void)removePublicKey:(NSString *)keyName;

@end
