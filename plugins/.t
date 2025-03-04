const Asena = require("../Utilis/events");

const { MessageType, Mimetype } = require("@adiwajshing/baileys");

const Language = require("../language");

const { webpToMp4 } = require("../Utilis/download");

const { sticker, addExif } = require("../Utilis/fFmpeg");

const Lang = Language.getString("sticker");

Asena.addCommand(

  { pattern: "s ?(.*)", fromMe: true, desc: Lang.STICKER_DESC },

  async (message, match) => {

    if (

      !message.reply_message ||

      (!message.reply_message.video && !message.reply_message.image)

    )

      return await message.sendMessage(Lang.NEED_REPLY);

    return await message.sendMessage(

      await sticker(

        "imagesticker",

        await message.reply_message.downloadAndSaveMediaMessage("sticker"),

        message.reply_message.image

          ? 1

          : message.reply_message.seconds < 10

            ? 2

            : 3,

        match

      ),

      {

        mimetype: Mimetype.webp,

        quoted: message.quoted,

        isAnimated: message.reply_message.video,

      },

      MessageType.sticker

    );

  }

);

Asena.addCommand(

  { pattern: "t ?(.*)", fromMe: true, desc: Lang.TAKE_DESC },

  async (message, match) => {

    if (!message.reply_message.sticker || !message.reply_message)

      return await message.sendMessage(Lang.TAKE_NEED_REPLY);

    return await message.sendMessage(

      await addExif(

        await message.reply_message.downloadAndSaveMediaMessage("take"),

        match

      ),

      {

        mimetype: Mimetype.webp,

        isAnimated: message.reply_message.animated,

        quoted: message.quoted,

      },

      MessageType.sticker

    );

  }

);
