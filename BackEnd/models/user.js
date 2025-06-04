const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const validator = require("validator");

const userSchema = new mongoose.Schema({
  userName: {
    type: String,
    required: true,
    trim: true,
  },
  password: {
    type: String,
    default: null,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    validate: {
      validator: function (v) {
        return validator.isEmail(v);
      },
      message: (props) => `${props.value} is not a valid email!`,
    },
  },
  phoneNumber: {
    type: String,
    required: true,
    validate: {
      validator: function (v) {
        return validator.isMobilePhone(v, 'any'); // or 'en-PK' for Pakistan-specific format
      },
      message: (props) => `${props.value} is not a valid phone number!`,
    },
  },
  cnic: {
    type: String,
    required: true,
    validate: {
      validator: function (v) {
        return /^[0-9]{5}-[0-9]{7}-[0-9]{1}$/.test(v); // CNIC format e.g. 12345-1234567-1
      },
      message: (props) => `${props.value} is not a valid CNIC!`,
    },
  },
  picture: {
    type: String,
    required: false,
    default: "",
  },
  personReputation: {
    type: Number,
    default: 0,
  },
  location: {
    type: { type: String, default: "Point" },
    coordinates: { type: [Number], required: false, default: [0, 0] },
  },
  accountId: {
    type: String,
    default: null,
  },
  fcmToken: {
    type: String,
    default: null,
  },
}, { timestamps: true });

userSchema.pre("save", async function (next) {
  if (!this.isModified("password") || !this.password) {
    return next();
  }

  try {
    const salt = await bcrypt.genSalt(10);
    this.password = await bcrypt.hash(this.password, salt);
    next();
  } catch (error) {
    next(error);
  }
});

userSchema.methods.comparePassword = async function (candidatePassword) {
  try {
    return await bcrypt.compare(candidatePassword, this.password);
  } catch (error) {
    throw new Error("Password comparison failed");
  }
};

userSchema.index({ location: '2dsphere' });

module.exports = mongoose.model("User", userSchema);
